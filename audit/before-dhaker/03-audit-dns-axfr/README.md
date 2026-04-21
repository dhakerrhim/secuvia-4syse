# 03 — Audit DNS — Zone Transfer (A3)

**Date :** 20/04/2026 — 16h30 → 16h50
**Contexte :** Test de la commande AXFR contre le serveur DNS hébergé sur DC01 depuis Kali. Un transfert de zone réussi expose **l'intégralité de la cartographie du SI** : noms d'hôtes, IPs, SRV records, comptes de service.

Voir l'analyse détaillée : **[dns-analysis.md](./dns-analysis.md)**

## Captures

| Fichier | Description |
|---|---|
| `axfr-success.png` | `dig axfr secuvia.local @10.10.10.10` → **transfert complet réussi**, zone dumpée |
| `axfr-stats.png` | Statistiques du dump (nombre d'enregistrements, temps de réponse, XFR bytes) |
| `zone-config-dc01.png` | Côté DC01 : `Get-DnsServerZone` → zone AD-Integrated avec `SecureSecondaries = TransferAnyServer` |

## Vulnérabilités identifiées

| ID | Nom | CVSS |
|---|---|:-:|
| **A3** | DNS Zone Transfer autorisé depuis n'importe quelle IP | 5.3 |

## Impact CIA

- **Confidentialité :** élevée — expose SRV, comptes service, topologie complète (reco facilitée pour attaquant).
- **Intégrité :** nulle — AXFR est lecture seule, pas de modif possible.
- **Disponibilité :** faible — des AXFR répétés peuvent générer du trafic inutile.

## Remédiation prévue (Phase 2)

Restreindre le transfert de zone aux seuls DC secondaires via PowerShell :
`Set-DnsServerPrimaryZone -Name secuvia.local -SecureSecondaries TransferToSecureServers -SecondaryServers @("10.10.10.11")`

Plus un firewall rule bloquant TCP/53 sortant hors liste blanche.
