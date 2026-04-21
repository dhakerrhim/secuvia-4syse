# Audit BEFORE — Dhaker (Phase 1 / J2)

**Projet :** Secuvia — Module 4SYSE Sécurité des Systèmes
**Auditeur :** Dhaker (binôme 4SYSE)
**Date :** 20 avril 2026
**Périmètre :** Domaine AD de test `secuvia.local` (DC01 + poste Kali attaquant)

---

## 1. Objectif

État des lieux **AVANT remédiation** du domaine Active Directory Secuvia : inventaire des services, identification des vulnérabilités exploitables, collecte de preuves horodatées. Aucune modification n'est faite sur les cibles — lecture seule / énumération / scan passif.

## 2. Méthodologie

Approche inspirée PTES + MITRE ATT&CK (phase Discovery & Credential Access) :

1. Reconnaissance locale Lab AD (DC01, Windows Server)
2. Reconnaissance réseau depuis attaquant Kali
3. Audit service par service : DNS, LDAP/LDAPS, Kerberos, WinRM
4. Déploiement du SIEM (preuve de remédiation A5)
5. Écriture d'une règle Sigma de détection (bonus)

## 3. Environnement de test

| Élément | Valeur |
|---|---|
| Hyperviseur | VMware Workstation 17 |
| Réseau isolé | VMnet5 — `10.10.10.0/24` (host-only) |
| Victime | DC01 — Windows Server 2022 — `10.10.10.10` |
| Attaquant | Kali 2025.1 — `10.10.10.100` |
| Compte utilisé | `user001` (utilisateur non-privilégié, simule employé) |
| Domaine | `secuvia.local` |

## 4. Sommaire des dossiers

| # | Dossier | Contenu | Preuves |
|---|---|---|---|
| 1 | [01-lab-ad/](./01-lab-ad/) | Inventaire AD côté Windows Server | 7 |
| 2 | [02-lab-kali/](./02-lab-kali/) | Validation connectivité Kali → DC | 3 |
| 3 | [03-audit-dns-axfr/](./03-audit-dns-axfr/) | Vulnérabilité A3 — Zone Transfer | 3 |
| 4 | [04-audit-tls/](./04-audit-tls/) | Vulnérabilité TLS-1 — LDAPS sans cert | 3 |
| 5 | [05-audit-nmap/](./05-audit-nmap/) | Inventaire 17 ports + scripts NSE | 4 |
| 6 | [06-siem-elk/](./06-siem-elk/) | SIEM ELK déployé (remédiation A5) | 4 |
| 7 | [07-sigma-bonus/](./07-sigma-bonus/) | Règle Sigma détection Kerberoasting | 1 |

**Total preuves :** 25 captures horodatées + 4 analyses techniques + 1 synthèse.

Voir aussi **[findings-summary.md](./findings-summary.md)** pour le tableau croisé des 8 vulnérabilités.

## 5. Limitations connues

- Lab isolé : pas de passerelle, pas d'Internet. Tests AXFR et LDAPS limités au périmètre interne.
- Compte attaquant = utilisateur standard `user001` (pas d'accès admin) : reflète le scénario *insider threat bas privilège*.
- `testssl.sh` exécuté dans sa version portable ; certaines sondes échouent car LDAPS ne répond pas (cohérent avec TLS-1).
- Les captures d'écran ne contiennent aucun secret : SID publics, ports publics, logs ELK vides à ce stade.

## 6. Suite — Phase 2 (Remédiation)

Voir `../../remediation/` : durcissement GPO, déploiement ADCS, restriction AXFR, tiering AD, règles Sigma additionnelles.
