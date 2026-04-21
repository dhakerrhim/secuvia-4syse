# Analyse technique — TLS-1 : LDAPS sans certificat

**Vulnérabilité :** TLS-1 — Port 636 non opérationnel, LDAP en clair forcé
**Cible :** DC01 (`10.10.10.10`) — Ports 389/636
**Normes :** RFC 4513 — Microsoft ADV190023 (LDAP signing) — CIS Benchmark DC §18.3.2

## 1. Description

Le port **636 (LDAPS)** n'accepte aucune connexion. Trois tests complémentaires le confirment :

1. `nmap -p 636 -sV` → `closed` / `filtered`
2. `openssl s_client -connect 10.10.10.10:636` → `Connection refused`
3. `testssl.sh dc01:636` → `No TLS protocol supported`

Conséquence : **tous les binds LDAP du domaine tombent sur le port 389 en clair**, ce qui expose les identifiants de tout compte qui interroge AD (y compris lors du logon utilisateur si le client ne force pas Kerberos).

## 2. Scoring CVSS 3.1

| Métrique | Valeur |
|---|---|
| Attack Vector | Adjacent (A) — nécessite un sniffer sur le segment |
| Attack Complexity | Low (L) |
| Privileges Required | None (N) |
| User Interaction | None (N) |
| Confidentiality | High (H) |
| Integrity | High (H) |
| Availability | None (N) |
| **Score de base** | **7.5 (High)** |
| Vecteur | `CVSS:3.1/AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:N` |

## 3. Impact métier

- **Vol d'identifiants** : un bind `user001` depuis un poste Kali envoie le mdp en clair (ou en NTLMv1/2 crackable).
- **MITM LDAP** : altération des attributs renvoyés (`memberOf`, `userAccountControl`), permettant élévation locale.
- **Non-conformité ANSSI** : le guide « Sécurité Active Directory » exige LDAPS + LDAP Signing.

## 4. Remédiation — Déploiement ADCS (Enterprise CA)

### 4.1 Installation rôle ADCS sur un serveur dédié

```powershell
Install-WindowsFeature AD-Certificate, ADCS-Cert-Authority, ADCS-Web-Enrollment -IncludeManagementTools

Install-AdcsCertificationAuthority `
    -CAType EnterpriseRootCA `
    -CryptoProviderName "RSA#Microsoft Software Key Storage Provider" `
    -KeyLength 4096 `
    -HashAlgorithmName SHA256 `
    -ValidityPeriod Years `
    -ValidityPeriodUnits 10 `
    -Force
```

### 4.2 Template « Domain Controller Authentication »

```powershell
# Publier le template
certutil -SetCATemplates +DomainControllerAuthentication

# Auto-enrollment via GPO Default Domain Policy :
# Computer Config > Policies > Windows Settings > Security > Public Key Policies
# → "Certificate Services Client - Auto-Enrollment" = Enabled
```

### 4.3 Forcer LDAP Signing + Channel Binding

GPO `Domain Controllers Policy` :

- `Domain controller: LDAP server signing requirements` = **Require signing**
- `Domain controller: LDAP server channel binding token requirements` = **Always**

### 4.4 Validation

```powershell
# Sur DC01 après redémarrage NTDS
Get-WinEvent -LogName "Directory Service" | Where-Object Id -in 2886,2887,2888,2889

# Depuis Kali, LDAPS doit maintenant répondre :
openssl s_client -connect 10.10.10.10:636 -showcerts
# → Certificat CN=dc01.secuvia.local présenté, chaîne valide
```

## 5. Validation post-remédiation

```bash
testssl.sh --quiet --color 0 10.10.10.10:636
# Attendu : TLS 1.2 & 1.3 OK, cipher suites modernes, pas de CBC vulnérable
```
