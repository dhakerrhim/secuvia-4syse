# 07 — Bonus Sigma — Règle de détection Kerberoasting

**Date :** 20/04/2026 — 18h45
**Contexte :** Écriture d'une règle **Sigma** (format universel de détection) ciblant A1 (Kerberoasting). Elle détecte les requêtes `TGS-REQ` pour un SPN chiffrées en RC4_HMAC — signature typique d'un `GetUserSPNs.py` (Impacket) ou d'un `Rubeus kerberoast`.

## Captures & fichiers

| Fichier | Description |
|---|---|
| `sigma_kerberoast.yml` | Règle Sigma prête à être compilée (→ Kibana, Splunk, Sentinel…) |
| `rule-created.png` | Aperçu VSCode de la règle avec linter Sigma valide |

## Lien avec la chaîne de détection

```
A1 (Kerberoasting SPN)
   ↓ ATT&CK T1558.003
Event ID 4769 (Kerberos service ticket)
   ↓
Winlogbeat → Logstash → Elasticsearch
   ↓
Sigma rule (ce dossier) → alerte Kibana → SOC
```

## Vulnérabilités couvertes (détection, pas correction)

| ID | Nom | Couverture |
|---|---|---|
| A1 | Kerberoasting | Détection des TGS-REQ en RC4 sur SPN (ETypes 0x17) |

## Impact CIA

N/A — règle de détection. L'alerte réduit le **temps de compromission détecté** (MTTD), ce qui atténue indirectement les risques sur les 3 axes.

## Remédiation prévue (Phase 2)

- Intégrer la règle dans Kibana Alerting (seuil : `count > 3 / 5min`).
- Compléter avec une règle T1558.004 (AS-REP Roasting).
- Ajouter des règles **LDAP anonymous bind**, **DNS AXFR success**, **WinRM HTTP auth** pour couvrir les autres vulnérabilités.
