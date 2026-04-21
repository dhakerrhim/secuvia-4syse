# Findings Summary — Audit BEFORE Secuvia

**Auditeur :** Dhaker · **Date :** 20/04/2026 · **Cible :** `secuvia.local` (10.10.10.0/24)

## Tableau croisé des vulnérabilités

| ID | Nom | Catégorie | CVSS 3.1 | Sévérité | Preuve principale | Statut |
|------|------------------------------------|--------------|:--------:|:--------:|------------------------------------------------------|:--------:|
| A1 | Kerberoasting — 3 SPN exposés | Cred. Access | 8.1 | Haute | [01-lab-ad/spn-kerberoastables.png](./01-lab-ad/spn-kerberoastables.png) | Ouvert |
| A3 | DNS Zone Transfer ouvert (AXFR) | Discovery | 5.3 | Moyenne | [03-audit-dns-axfr/axfr-success.png](./03-audit-dns-axfr/axfr-success.png) | Ouvert |
| A4 | Pas de tiering AD — 3 Domain Admins | Priv. Esc. | 7.5 | Haute | [01-lab-ad/domain-admins-list.png](./01-lab-ad/domain-admins-list.png) | Ouvert |
| A5 | Pas de journalisation centralisée | Defense Evas.| 7.5 | Haute | [06-siem-elk/kibana-home.png](./06-siem-elk/kibana-home.png) | Remédié |
| TLS-1 | LDAPS sans certificat (port 636 fermé) | Crypto | 7.5 | Haute | [04-audit-tls/testssl-no-protocol.png](./04-audit-tls/testssl-no-protocol.png) | Ouvert |
| TLS-2 | LDAP en clair sur port 389 | Crypto | 6.5 | Moyenne | [05-audit-nmap/ad-ports-dc01.png](./05-audit-nmap/ad-ports-dc01.png) | Ouvert |
| NET-1 | WinRM HTTP non-TLS (5985) | Crypto/Net | 6.1 | Moyenne | [05-audit-nmap/ad-ports-dc01.png](./05-audit-nmap/ad-ports-dc01.png) | Ouvert |
| NET-2 | 17 ports exposés sur le DC | Exposure | 4.3 | Basse | [05-audit-nmap/scan-subnet.png](./05-audit-nmap/scan-subnet.png) | Ouvert |

## Couverture CIA

| ID | Confidentialité | Intégrité | Disponibilité |
|-------|:-:|:-:|:-:|
| A1 | X | X | - |
| A3 | X | - | - |
| A4 | X | X | X |
| A5 | X | X | X |
| TLS-1 | X | X | - |
| TLS-2 | X | X | - |
| NET-1 | X | X | - |
| NET-2 | X | - | - |

## Bilan

- **8 vulnérabilités** identifiées (3 Hautes, 4 Moyennes, 1 Basse).
- **1 vulnérabilité déjà remédiée** (A5, déploiement ELK).
- **25 preuves horodatées** (captures Lab + audits + SIEM) réparties en 7 domaines.
- **1 règle Sigma** fournie en bonus pour détection Kerberoasting (voir [07-sigma-bonus/](./07-sigma-bonus/)).

Scoring CVSS calculé via calculateur FIRST v3.1 avec vecteur `AV:N/AC:L/PR:L/UI:N/S:U`.
