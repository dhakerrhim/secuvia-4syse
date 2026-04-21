# Mise en place SIEM ELK — Remédiation A5

**Vulnérabilité traitée :** A5 — Absence totale de journalisation centralisée
**Cible :** poste audit Secuvia (`10.10.10.50`, Linux Ubuntu 22.04)
**Stack :** Elasticsearch 8.13 + Kibana 8.13 + Logstash 8.13 (OSS-compatible via Docker)

## 1. Architecture

```
 DC01 (10.10.10.10)              Secuvia-SIEM (10.10.10.50)
 ┌──────────────────┐            ┌────────────────────────────────────┐
 │ Winlogbeat       │  TLS 5044  │  Logstash :5044                    │
 │  └─ Sec. EventLog├───────────►│    └─ pipeline ad-auth.conf        │
 │  └─ DNS EventLog │            │       └─► Elasticsearch :9200      │
 └──────────────────┘            │              └─ index winlogs-*    │
                                 │                    ▲               │
                                 │                    │               │
                                 │        Kibana :5601 (UI)           │
                                 └────────────────────────────────────┘
```

## 2. docker-compose.yml (résumé — fichier complet dans `../../lab-config/siem/`)

```yaml
version: "3.8"
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.13.4
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
      - ES_JAVA_OPTS=-Xms1g -Xmx1g
      - cluster.name=secuvia-siem
    ports: ["9200:9200"]
    volumes: [esdata:/usr/share/elasticsearch/data]

  kibana:
    image: docker.elastic.co/kibana/kibana:8.13.4
    depends_on: [elasticsearch]
    ports: ["5601:5601"]
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200

  logstash:
    image: docker.elastic.co/logstash/logstash:8.13.4
    depends_on: [elasticsearch]
    ports: ["5044:5044"]
    volumes: [./pipeline:/usr/share/logstash/pipeline:ro]

volumes:
  esdata:
```

## 3. Démarrage (captures de preuve)

| Étape | Commande | Capture |
|---|---|---|
| 1. Up | `docker compose up -d` | `docker-compose-up.png` |
| 2. État | `docker ps` | `docker-ps-running.png` |
| 3. ES OK | `curl localhost:9200` | `elasticsearch-ok.png` |
| 4. Kibana | `http://10.10.10.50:5601` | `kibana-home.png` |

## 4. Ingestion — Winlogbeat sur DC01

```yaml
# C:\Program Files\Winlogbeat\winlogbeat.yml (extrait)
winlogbeat.event_logs:
  - name: Security
    event_id: 4624,4625,4634,4648,4768,4769,4771,4776,4672,4720,4732
  - name: Microsoft-Windows-DNSServer/Audit
    event_id: 256,257,258
output.logstash:
  hosts: ["10.10.10.50:5044"]
  ssl.certificate_authorities: ["C:/ProgramData/winlogbeat/ca.pem"]
```

## 5. Index patterns & Dashboards

- Pattern : `winlogbeat-*` sur `@timestamp`.
- Dashboard `AD-Auth-Anomalies` : logons 4625 > seuil, tickets 4769 avec chiffrement RC4 (Kerberoast), pics 4776.
- Dashboard `DNS-AXFR` : Event 257 avec code de retour successful + IP source hors whitelist.

## 6. Intégration règles Sigma

```bash
# Compilation Sigma → DSL Elasticsearch
sigma convert -t lucene ./rules/sigma_kerberoast.yml > ./rules/out.json
# Puis import via API Kibana Detection Engine
curl -XPOST "http://kibana:5601/api/detection_engine/rules" \
     -H "kbn-xsrf: true" -d @./rules/out.json
```

## 7. Correspondance avec A5 — Avant / Après

| Critère | Avant | Après |
|---|:-:|:-:|
| Logs agrégés | Non | Oui (DC01 → ELK) |
| Rétention centralisée | 0 j | 30 j (index lifecycle) |
| Détection temps réel | Non | Oui (règles Sigma) |
| Tableaux de bord | Non | 2 dashboards Kibana |

## 8. Suite — Phase 3

- Ajouter Filebeat sur Kali (logs d'attaque pour rejeu & validation détection).
- Chiffrer Winlogbeat → Logstash avec certificat ADCS.
- Backup snapshot ES quotidien sur volume dédié.
