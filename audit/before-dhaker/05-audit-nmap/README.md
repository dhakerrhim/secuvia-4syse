# 05 — Audit Nmap — Inventaire des services (TLS-2, NET-1, NET-2)

**Date :** 20/04/2026 — 16h45 → 17h05
**Contexte :** Cartographie complète du DC01 et du subnet `10.10.10.0/24` depuis Kali. Identification des ports ouverts, versions, et tests de vulnérabilités via scripts NSE.

Voir l'analyse détaillée : **[nmap-analysis.md](./nmap-analysis.md)**

## Captures

| Fichier | Description |
|---|---|
| `ad-ports-dc01.png` | Scan complet DC01 `nmap -sV -sC -p- 10.10.10.10` → 17 ports ouverts |
| `ad-ports-quick.png` | Scan rapide top-1000 (validation rapide) |
| `scan-subnet.png` | `nmap -sn 10.10.10.0/24` → discovery, seul DC01 actif (plus Kali) |
| `vuln-scripts.png` | `nmap --script vuln,smb-vuln-* 10.10.10.10` → pas de CVE smb, mais 389/5985 non-TLS confirmés |

## Vulnérabilités identifiées

| ID | Nom | CVSS |
|---|---|:-:|
| **TLS-2** | LDAP en clair sur port 389 (pas de forçage signing côté client) | 6.5 |
| **NET-1** | WinRM en HTTP (5985) au lieu de HTTPS (5986) | 6.1 |
| **NET-2** | Surface d'attaque de 17 ports exposés sur DC | 4.3 |

## Impact CIA

- **Confidentialité :** moyenne — 389 et 5985 sont sniffables.
- **Intégrité :** moyenne — WinRM HTTP permet le hijack de session admin à distance.
- **Disponibilité :** faible — surface accrue = plus de cibles pour DoS.

## Remédiation prévue (Phase 2)

- Fermeture des ports non essentiels via GPO **Windows Defender Firewall** (restriction par domaine).
- Bascule WinRM → HTTPS uniquement (5986) avec même certif que LDAPS.
- GPO `Domain controller: LDAP server signing requirements` = `Require signing`.
- Activation **SMB Signing** partout (CVSS baseline NET-1 supplémentaire en attendant TLS-1).
