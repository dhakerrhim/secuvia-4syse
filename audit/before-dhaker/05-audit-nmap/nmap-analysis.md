# Analyse technique — Inventaire des 17 ports exposés sur DC01

**Vulnérabilités couvertes :** TLS-2 (LDAP 389), NET-1 (WinRM HTTP), NET-2 (surface d'attaque)
**Cible :** DC01 (`10.10.10.10`)
**Normes :** CIS Benchmark Windows Server 2022 §9 — Microsoft AD Port Requirements (KB832017)

## 1. Inventaire complet — `nmap -sV -sC -p- 10.10.10.10`

| Port | Proto | Service | Banner | Nécessaire ? | Risque |
|:---:|:---:|---|---|:---:|---|
| 53 | TCP/UDP | DNS | Microsoft DNS 10.0.20348 | Oui | A3 (AXFR) |
| 88 | TCP | Kerberos | Microsoft Windows Kerberos | Oui | A1 (kerberoast) |
| 135 | TCP | MS-RPC | Microsoft Windows RPC | Oui | RPC enum |
| 139 | TCP | NetBIOS-SSN | SMBv1 legacy | **Non** | Should be disabled |
| 389 | TCP/UDP | LDAP | Microsoft Windows AD LDAP | Oui (avec signing) | **TLS-2** |
| 445 | TCP | SMB | Microsoft SMB 3.1.1 | Oui | SMB signing à activer |
| 464 | TCP/UDP | kpasswd | Kerberos password | Oui | — |
| 593 | TCP | HTTP-RPC-EPMAP | RPC over HTTP | Contextuel | à fermer si non utilisé |
| 636 | TCP | LDAPS | **closed** | Oui (à activer) | **TLS-1** |
| 3268 | TCP | LDAP-GC | Global Catalog LDAP | Oui (avec signing) | même risque que 389 |
| 3269 | TCP | LDAPS-GC | **closed** | Oui (à activer) | même risque que TLS-1 |
| 5985 | TCP | WinRM-HTTP | HTTP 1.1 sans TLS | **Non** | **NET-1** |
| 5986 | TCP | WinRM-HTTPS | **closed** | Oui (à activer) | dépend TLS-1 |
| 9389 | TCP | ADWS | AD Web Services | Oui | — |
| 49664+ | TCP | RPC dynamic | RPC endpoints | Oui | à restreindre |

**17 ports en écoute** → surface d'attaque significative mais majoritairement fonctionnelle (AD exige 7–10 ports). Le problème est l'**absence de TLS** sur les services critiques (389, 5985) et la présence du **port 139** (NetBIOS legacy).

## 2. Scripts NSE déclenchés — `nmap --script vuln,smb-vuln-*`

- `smb-vuln-ms17-010` → **Not vulnerable** (patch 2017 appliqué, bon point)
- `smb-vuln-cve-2020-0796` → **Not vulnerable** (SMBGhost patché)
- `ldap-search` → anonymous bind refusé (bon point)
- `ssl-enum-ciphers` → pas de TLS détecté sur 636 (voir TLS-1)

## 3. Scoring CVSS

| ID | Score | Vecteur |
|---|:---:|---|
| TLS-2 | 6.5 | `CVSS:3.1/AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:L/A:N` |
| NET-1 | 6.1 | `CVSS:3.1/AV:A/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:N` |
| NET-2 | 4.3 | `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N` |

## 4. Remédiation — Durcissement ciblé

### 4.1 Fermer NetBIOS (139) et désactiver SMBv1

```powershell
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
Set-NetBiosOverTcpIp -InterfaceAlias "Ethernet0" -Enabled $false
```

### 4.2 WinRM : passer en HTTPS obligatoire

```powershell
# Supprimer le listener HTTP
winrm delete winrm/config/Listener?Address=*+Transport=HTTP

# Créer le listener HTTPS (nécessite le cert ADCS déployé par TLS-1)
$thumb = (Get-ChildItem Cert:\LocalMachine\My | Where-Object Subject -like "*dc01.secuvia.local*").Thumbprint
New-Item -Path WSMan:\Localhost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $thumb -Force

# Firewall
New-NetFirewallRule -DisplayName "WinRM HTTPS" -Protocol TCP -LocalPort 5986 -Action Allow
Remove-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)" -ErrorAction SilentlyContinue
```

### 4.3 Forcer LDAP Signing & fermer les RPC dynamiques inutilisés

Voir `tls-analysis.md` §4.3 + GPO **Security Options** pour LDAP Signing côté client.

## 5. Validation

```bash
# Attendu après durcissement : environ 10 ports ouverts, tous en TLS
nmap -p- -sV 10.10.10.10
```
