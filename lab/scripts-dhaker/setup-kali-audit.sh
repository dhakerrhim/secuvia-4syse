#!/bin/bash
# =============================================================================
#  setup-kali-audit.sh
#
#  Installation complete des outils d'audit pour le projet Secuvia 4SYSE
#  (Adam & Dhaker) sur Kali Linux / Ubuntu / Debian
#
#  Outils installes :
#    - bloodhound-python (collecteur AD)
#    - BloodHound Community Edition (interface graphique, via Docker)
#    - Certipy-AD (audit et exploit ADCS)
#    - Impacket (Kerberoast, secretsdump, etc.)
#    - Nmap (scan reseau)
#    - testssl.sh (audit TLS)
#    - hashcat + rockyou (cracking)
#    - Outils annexes : dig, wireshark, responder, netexec
#
#  Utilisation :
#    chmod +x setup-kali-audit.sh
#    ./setup-kali-audit.sh
#
#  Duree estimee : 15 a 25 minutes (selon la connexion)
# =============================================================================

set -e  # Arret immediat sur erreur

# ------------------------------------------------------------------------------
# Couleurs pour l'affichage
# ------------------------------------------------------------------------------
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

banner() {
    echo ""
    echo -e "${BLUE}============================================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}============================================================${NC}"
    echo ""
}

section() {
    echo ""
    echo -e "${YELLOW}[+] $1${NC}"
}

ok() {
    echo -e "${GREEN}    [OK] $1${NC}"
}

warn() {
    echo -e "${YELLOW}    [WARN] $1${NC}"
}

error() {
    echo -e "${RED}    [ERR] $1${NC}"
}

# ------------------------------------------------------------------------------
# Verifications prealables
# ------------------------------------------------------------------------------
banner "Setup audit Secuvia - Kali Linux"

if [ "$EUID" -ne 0 ]; then
    error "Ce script doit etre execute en tant que root (sudo)."
    echo "Relance-le avec : sudo ./setup-kali-audit.sh"
    exit 1
fi

section "Verification connexion Internet..."
if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
    ok "Internet OK"
else
    warn "Pas de connexion Internet detectee. Certaines installations vont echouer."
fi

# ------------------------------------------------------------------------------
# 1. Mise a jour du systeme
# ------------------------------------------------------------------------------
section "1/8 - Mise a jour du systeme (apt update)..."
apt update -y > /dev/null 2>&1
ok "Paquets mis a jour"

# ------------------------------------------------------------------------------
# 2. Outils systeme essentiels
# ------------------------------------------------------------------------------
section "2/8 - Installation des outils systeme..."
apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    curl \
    wget \
    net-tools \
    dnsutils \
    iputils-ping \
    ldap-utils \
    > /dev/null 2>&1
ok "Outils systeme installes (python3, git, curl, dnsutils, ldap-utils)"

# ------------------------------------------------------------------------------
# 3. Outils reseau (scan)
# ------------------------------------------------------------------------------
section "3/8 - Installation Nmap + testssl.sh + Wireshark..."
apt install -y nmap wireshark tshark > /dev/null 2>&1
ok "Nmap + Wireshark installes"

# testssl.sh (clone Git car plus recent que le paquet apt)
if [ ! -d /opt/testssl.sh ]; then
    git clone --depth 1 https://github.com/drwetter/testssl.sh.git /opt/testssl.sh > /dev/null 2>&1
    ln -sf /opt/testssl.sh/testssl.sh /usr/local/bin/testssl.sh
    ok "testssl.sh clone dans /opt/testssl.sh (symlink -> testssl.sh)"
else
    ok "testssl.sh deja present"
fi

# ------------------------------------------------------------------------------
# 4. Outils d'attaque AD (BloodHound + Impacket + Certipy)
# ------------------------------------------------------------------------------
section "4/8 - Installation bloodhound-python + Impacket + Certipy..."

# Option 1 : via apt (plus stable sur Kali)
if apt install -y bloodhound-python impacket-scripts > /dev/null 2>&1; then
    ok "bloodhound-python + impacket installes via apt"
else
    warn "Installation apt echouee, passage a pip..."
    pip3 install bloodhound impacket --break-system-packages > /dev/null 2>&1
    ok "bloodhound + impacket installes via pip"
fi

# Certipy : toujours via pip (version plus recente que apt)
pip3 install certipy-ad --break-system-packages > /dev/null 2>&1 || \
    pip3 install certipy-ad > /dev/null 2>&1
ok "certipy-ad installe"

# NetExec (successeur de CrackMapExec, tres utile)
pip3 install netexec --break-system-packages > /dev/null 2>&1 || true
ok "netexec installe (alias nxc)"

# ------------------------------------------------------------------------------
# 5. Hashcat + rockyou.txt
# ------------------------------------------------------------------------------
section "5/8 - Installation hashcat + wordlist rockyou..."
apt install -y hashcat > /dev/null 2>&1
ok "hashcat installe"

# Decompresser rockyou.txt si present (Kali l'a zippee par defaut)
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
    gunzip -k /usr/share/wordlists/rockyou.txt.gz
    ok "rockyou.txt decompresse dans /usr/share/wordlists/"
elif [ -f /usr/share/wordlists/rockyou.txt ]; then
    ok "rockyou.txt deja present"
else
    warn "rockyou.txt introuvable, telechargement..."
    mkdir -p /usr/share/wordlists
    wget -q https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt \
        -O /usr/share/wordlists/rockyou.txt
    ok "rockyou.txt telecharge"
fi

# ------------------------------------------------------------------------------
# 6. Responder (rogue DHCP/LLMNR pour Dhaker si besoin)
# ------------------------------------------------------------------------------
section "6/8 - Installation Responder (optionnel, utile pour demo rogue DHCP)..."
apt install -y responder > /dev/null 2>&1 || \
    pip3 install responder --break-system-packages > /dev/null 2>&1 || true
ok "Responder installe"

# ------------------------------------------------------------------------------
# 7. Docker + BloodHound Community Edition
# ------------------------------------------------------------------------------
section "7/8 - Installation Docker + BloodHound CE..."

if ! command -v docker &> /dev/null; then
    apt install -y docker.io docker-compose > /dev/null 2>&1
    systemctl enable docker > /dev/null 2>&1
    systemctl start docker > /dev/null 2>&1
    ok "Docker installe et demarre"
else
    ok "Docker deja present"
fi

# Ajouter l'utilisateur courant au groupe docker (pas besoin de sudo pour docker)
CURRENT_USER=${SUDO_USER:-$USER}
if ! groups $CURRENT_USER | grep -q docker; then
    usermod -aG docker $CURRENT_USER
    ok "$CURRENT_USER ajoute au groupe docker (logout/login pour que ca prenne effet)"
fi

# Preparer BloodHound CE
BLOODHOUND_DIR="/home/$CURRENT_USER/bloodhound-ce"
if [ ! -d "$BLOODHOUND_DIR" ]; then
    mkdir -p "$BLOODHOUND_DIR"
    curl -L https://ghst.ly/getbhce -o "$BLOODHOUND_DIR/docker-compose.yml" 2>/dev/null
    chown -R $CURRENT_USER:$CURRENT_USER "$BLOODHOUND_DIR"
    ok "docker-compose.yml BloodHound CE telecharge dans $BLOODHOUND_DIR"
else
    ok "Dossier BloodHound CE deja present"
fi

# ------------------------------------------------------------------------------
# 8. Organisation du workspace audit
# ------------------------------------------------------------------------------
section "8/8 - Creation de l'arborescence de travail..."

WORKSPACE="/home/$CURRENT_USER/secuvia-audit"
mkdir -p "$WORKSPACE"/{bloodhound,certipy,kerberoast,nmap,testssl,dns,screenshots}
chown -R $CURRENT_USER:$CURRENT_USER "$WORKSPACE"
ok "Workspace cree : $WORKSPACE"

# ------------------------------------------------------------------------------
# Recapitulatif final
# ------------------------------------------------------------------------------
banner "Installation terminee"

echo -e "${GREEN}Outils installes :${NC}"
echo "  - bloodhound-python     : $(which bloodhound-python 2>/dev/null || echo 'via python3 -m bloodhound')"
echo "  - BloodHound CE         : $BLOODHOUND_DIR (a demarrer avec docker-compose up)"
echo "  - certipy               : $(which certipy 2>/dev/null || echo 'non trouve')"
echo "  - impacket (GetUserSPNs): $(which GetUserSPNs.py 2>/dev/null || which impacket-GetUserSPNs 2>/dev/null || echo 'non trouve')"
echo "  - netexec (nxc)         : $(which nxc 2>/dev/null || echo 'non trouve')"
echo "  - nmap                  : $(which nmap)"
echo "  - testssl.sh            : $(which testssl.sh)"
echo "  - hashcat               : $(which hashcat)"
echo "  - wireshark             : $(which wireshark)"
echo ""

echo -e "${YELLOW}PROCHAINES ETAPES :${NC}"
echo ""
echo "  1. Verifier la connectivite vers DC01 :"
echo "     ping 10.10.10.10"
echo "     nslookup secuvia.local 10.10.10.10"
echo ""
echo "  2. Demarrer BloodHound CE :"
echo "     cd $BLOODHOUND_DIR"
echo "     sudo docker-compose up -d"
echo "     # Attendre 2-3 min"
echo "     sudo docker-compose logs bloodhound | grep -i 'initial password'"
echo "     # Puis ouvrir http://localhost:8080 (admin / mot-de-passe-affiche)"
echo ""
echo "  3. Lancer la collecte AD :"
echo "     cd $WORKSPACE/bloodhound"
echo "     bloodhound-python -u user001 -p 'Secuvia2024!' \\"
echo "         -d secuvia.local -ns 10.10.10.10 -c All --zip"
echo ""
echo "  4. Audit ADCS avec Certipy :"
echo "     cd $WORKSPACE/certipy"
echo "     certipy find -u user001@secuvia.local -p 'Secuvia2024!' \\"
echo "         -dc-ip 10.10.10.10 -vulnerable -stdout"
echo ""
echo "  5. Kerberoasting :"
echo "     cd $WORKSPACE/kerberoast"
echo "     impacket-GetUserSPNs secuvia.local/user001:'Secuvia2024!' \\"
echo "         -dc-ip 10.10.10.10 -request -outputfile hashes.txt"
echo "     hashcat -m 13100 hashes.txt /usr/share/wordlists/rockyou.txt"
echo ""
echo -e "${GREEN}Bon audit ! 🎯${NC}"
echo ""
