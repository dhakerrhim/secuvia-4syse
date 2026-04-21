# 06 — SIEM ELK (Remédiation A5 — journalisation centralisée)

**Date :** 20/04/2026 — 18h00 → 18h30
**Contexte :** Déploiement d'une stack **ELK** (Elasticsearch + Kibana + Logstash) en Docker sur le poste audit Secuvia, destinée à agréger les Event Logs AD, les logs DNS, les logs nmap et les alertes Sigma. Ce dossier constitue la **remédiation déployée** de la vulnérabilité A5 (« pas de journalisation »).

Voir la doc détaillée : **[siem-setup.md](./siem-setup.md)**

## Captures

| Fichier | Description |
|---|---|
| `docker-compose-up.png` | `docker compose up -d` → démarrage de la stack (3 conteneurs) |
| `docker-ps-running.png` | `docker ps` → `elasticsearch`, `kibana`, `logstash` en état `Up` |
| `elasticsearch-ok.png` | `curl localhost:9200` → réponse JSON `cluster_name: secuvia-siem` |
| `kibana-home.png` | Kibana UI accessible sur `http://10.10.10.50:5601` — home page loaded |

## Vulnérabilités identifiées (remédiées)

| ID | Nom | CVSS | Statut |
|---|---|:-:|:-:|
| **A5** | Absence totale de journalisation centralisée | 7.5 | **Remédié** |

## Impact CIA (avant remédiation)

- **Confidentialité :** élevée — aucune traçabilité des accès en cas de fuite.
- **Intégrité :** élevée — un attaquant peut effacer les logs locaux sans preuve.
- **Disponibilité :** élevée — sans SIEM, pas de détection d'anomalie = incident prolongé.

## Remédiation prévue / déployée (Phase 2)

1. **Stack ELK** démarrée (captures ci-dessus).
2. Installation de **Winlogbeat** sur DC01 + collecte Security Event Log (4624, 4625, 4768, 4769, 4776).
3. Import des règles **Sigma** (voir `../07-sigma-bonus/`) compilées en requêtes Lucene pour Kibana.
4. Dashboard « AD Auth Anomalies » (à livrer en phase 3).
