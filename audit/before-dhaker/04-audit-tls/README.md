# 04 — Audit TLS — LDAPS sans certificat (TLS-1)

**Date :** 20/04/2026 — 17h00 → 17h15
**Contexte :** Vérification du chiffrement des communications annuaire. LDAPS (port 636) doit présenter un certificat valide et négocier TLS ≥ 1.2. Résultat : **port 636 ne répond pas** → les requêtes LDAP tombent en clair sur 389.

Voir l'analyse détaillée : **[tls-analysis.md](./tls-analysis.md)**

## Captures

| Fichier | Description |
|---|---|
| `nmap-port-636.png` | `nmap -p 636 -sV 10.10.10.10` → `closed` / `filtered` |
| `openssl-no-cert.png` | `openssl s_client -connect dc01:636` → `connect: Connection refused` / no cert |
| `testssl-no-protocol.png` | `testssl.sh --quiet dc01:636` → « No TLS protocol supported » |

## Vulnérabilités identifiées

| ID | Nom | CVSS |
|---|---|:-:|
| **TLS-1** | LDAPS non opérationnel (port 636 fermé, pas de certificat AD installé) | 7.5 |

## Impact CIA

- **Confidentialité :** élevée — les binds LDAP (y compris `user001` → requête AD) transitent en clair sur 389 ; un sniffer sur VMnet5 récupère identifiants et attributs.
- **Intégrité :** élevée — sans TLS, un MITM peut altérer les réponses LDAP (attribute spoofing).
- **Disponibilité :** nulle.

## Remédiation prévue (Phase 2)

1. Déploiement d'une PKI interne **ADCS** (Enterprise CA) — voir `../../remediation/adcs-setup/`.
2. Auto-enrollment d'un certificat « Domain Controller Authentication » sur DC01.
3. Redémarrage NTDS + validation `ldp.exe` SSL.
4. Forçage LDAP Signing & Channel Binding via GPO `Domain Controllers`.
