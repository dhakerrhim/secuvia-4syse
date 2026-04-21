# Analyse technique — A3 : DNS Zone Transfer ouvert

**Vulnérabilité :** A3 — Zone Transfer AXFR autorisée
**Cible :** DC01 (`10.10.10.10`) — Zone `secuvia.local`
**Norme :** RFC 5936 (AXFR) — OWASP API Security — CIS Benchmark Windows Server 2022 §5.2

## 1. Description

Le serveur DNS de DC01 accepte les requêtes **AXFR** (full Zone Transfer) depuis n'importe quelle adresse IP du réseau, y compris depuis le poste Kali non autorisé. La zone `secuvia.local` étant AD-Integrated, le transfert expose :

- Tous les hôtes (A / AAAA)
- Les SRV records Kerberos (`_kerberos._tcp`, `_ldap._tcp`) → localisation des DC
- Les SRV records GC (Global Catalog)
- Les comptes de service (si mdp-sync DNS activé)

## 2. Reproduction (preuve : `axfr-success.png`)

```bash
# Depuis Kali 10.10.10.100
dig axfr secuvia.local @10.10.10.10
# → ; Transfer succeeded
# → N records returned
```

## 3. Scoring CVSS 3.1

| Métrique | Valeur |
|---|---|
| Attack Vector | Network (N) |
| Attack Complexity | Low (L) |
| Privileges Required | None (N) |
| User Interaction | None (N) |
| Scope | Unchanged (U) |
| Confidentiality | Low (L) |
| Integrity | None (N) |
| Availability | None (N) |
| **Score de base** | **5.3 (Medium)** |
| Vecteur | `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N` |

## 4. Impact métier

Un attaquant externe ou un insider récupère la **cartographie complète du SI** en 1 requête. Cela prépare toutes les attaques suivantes :
- Kerberoasting ciblé sur les SPN découverts (lien avec A1)
- AS-REP Roasting sur comptes sans pré-auth
- Lateral movement direct (IPs connues, pas de scan nécessaire)

## 5. Remédiation PowerShell

```powershell
# Sur DC01, en admin
Import-Module DnsServer

# Restreindre AXFR aux DC secondaires autorisés uniquement
Set-DnsServerPrimaryZone `
    -Name "secuvia.local" `
    -SecureSecondaries TransferToSecureServers `
    -SecondaryServers @("10.10.10.11","10.10.10.12")

# Désactiver la notification broadcast
Set-DnsServerPrimaryZone -Name "secuvia.local" -Notify NoNotify

# Vérification
Get-DnsServerZone -Name "secuvia.local" | Select-Object ZoneName,SecureSecondaries,SecondaryServers
```

## 6. Durcissement complémentaire

- Firewall Windows : bloquer TCP/53 entrant sauf depuis IP des DC secondaires.
- Activer DNS Query Logging (Event ID 257) vers Winlogbeat → ELK.
- Règle Sigma : détecter un AXFR réussi depuis une IP hors whitelist (future livraison).

## 7. Validation post-remédiation

```bash
# Depuis Kali (non whitelisté) → doit échouer
dig axfr secuvia.local @10.10.10.10
# Résultat attendu : ; Transfer failed.
```
