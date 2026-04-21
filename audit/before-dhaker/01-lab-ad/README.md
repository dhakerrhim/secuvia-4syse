# 01 — Lab Active Directory (Reconnaissance côté DC01)

**Date :** 20/04/2026 — 14h00 → 15h30
**Contexte :** Énumération locale du domaine `secuvia.local` depuis DC01 (Windows Server 2022). Compte utilisé : `user001` (non-privilégié). Objectif : valider le lab et exposer les faiblesses AD de conception.

## Captures

| Fichier | Description |
|---|---|
| `domaine-cree.png` | Installation du rôle ADDS + promotion DC01, domaine `secuvia.local` opérationnel |
| `ipconfig-dc01.png` | Configuration réseau DC01 : IP `10.10.10.10/24`, DNS self |
| `nombre-users.png` | `Get-ADUser -Filter *` — inventaire des comptes du domaine |
| `ou-structure.png` | Structure des Unités d'Organisation (flat, pas de tiering) |
| `sid-domain-admins.png` | SID du groupe Domain Admins (base pour ACL audit) |
| `spn-kerberoastables.png` | `Get-ADUser -Filter 'ServicePrincipalName -like "*"'` → **3 SPN exposés** |
| `domain-admins-list.png` | `Get-ADGroupMember "Domain Admins"` → **3 membres** (`administrator`, `svc-sql`, `svc-web`) |

## Vulnérabilités identifiées

| ID | Nom | CVSS |
|---|---|:-:|
| **A1** | Kerberoasting — 3 SPN avec mots de passe crackables offline | 8.1 |
| **A4** | Pas de tiering — 3 comptes Domain Admins, dont 2 comptes de service | 7.5 |

## Impact CIA

- **Confidentialité :** élevée — un ticket Kerberos volé permet de cracker le hash du compte de service, puis mouvement latéral.
- **Intégrité :** élevée — compromission d'un DA = réécriture complète du domaine.
- **Disponibilité :** moyenne — un DA compromis peut chiffrer AD (ransomware).

## Remédiation prévue (Phase 2)

- A1 : mot de passe complexe 32+ caractères sur les comptes SPN, passage vers **gMSA** (group-Managed Service Accounts).
- A4 : séparation des tiers (Tier 0 / Tier 1 / Tier 2), déplacement des comptes de service hors de Domain Admins, activation de **Protected Users**.
