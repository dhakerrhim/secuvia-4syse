---
marp: true
theme: default
paginate: true
size: 16:9
header: "Secuvia — 4SYSE 2026"
footer: "Adam & Dhaker RHIMI · 22 avril 2026"
style: |
  section { font-family: "Calibri", "Segoe UI", sans-serif; background: #fafbfc; }
  h1 { color: #0b3d91; border-bottom: 3px solid #0b3d91; padding-bottom: 0.3em; }
  h2 { color: #0b3d91; }
  code { background: #eef2f7; padding: 2px 6px; border-radius: 4px; }
  table { font-size: 0.85em; }
  .crit { color: #c0392b; font-weight: bold; }
  .ok { color: #1e8449; font-weight: bold; }
  .warn { color: #d68910; font-weight: bold; }
  .small { font-size: 0.8em; color: #555; }
---

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _header: "" -->
<!-- _footer: "" -->

# Audit & Remédiation **Secuvia**
## Projet 4SYSE · Promotion 2025-2026

**Adam & Dhaker RHIMI**
22 avril 2026 — Soutenance finale

<br>

> De *Kerberoasting réussi en 4 min* à *SIEM opérationnel avec alertes Sigma* — en 48 heures.

<p class="small">15 min exposé · 5 min Q&R · Tour de table final</p>

---

<!-- Slide 2 — Agenda & répartition (Dhaker — 1 min) -->

# Agenda — 10 slides, 15 minutes

| # | Slide | Présentateur | Durée |
|:-:|---|:---:|:---:|
| 1 | Page de garde | Dhaker | — |
| 2 | **Agenda (ici)** | Dhaker | 1 min |
| 3 | Contexte & périmètre | Dhaker | 1 min |
| 4 | Chaîne d'attaque : 3 vulns en démo | Adam | 2 min |
| 5 | A1 Kerberoasting — BEFORE/AFTER | Adam | 2 min |
| 6 | A2 ADCS ESC1 — BEFORE/AFTER | Adam | 2 min |
| 7 | A3 DNS AXFR + R3 | Dhaker | 1 min |
| 8 | A5 → R5 — SIEM ELK opérationnel | Dhaker | 2 min |
| 9 | Registre + Plan 90j | Dhaker | 2 min |
| 10 | Conclusion + risques résiduels | Adam | 2 min |

---

<!-- Slide 3 — Contexte & Périmètre (Dhaker — 1 min) -->

# Contexte & périmètre

**Client fictif** : Secuvia, PME industrielle, **50 postes**, domaine `secuvia.local`.

| Composant | Rôle | IP |
|---|---|---|
| DC01 | Contrôleur de domaine, DNS, ADCS | 10.10.10.10 |
| SIEM01 | Pile ELK 8.13 (Ubuntu 22.04) | 10.10.10.50 |
| Kali | Poste audit offensif | 10.10.10.100 |

**Mission (48 h)** — Audit → Exploit → Remédier → Livrer registre + plan 90 j.

**Méthode** — Boîte grise (1 compte utilisateur `j.dupont`) · Cadres ANSSI, CIS, MITRE ATT&CK v15 · Scoring CVSS 3.1.

---

<!-- Slide 4 — Chaîne d'attaque (Adam — 2 min) -->

# Chaîne d'attaque démontrée : **utilisateur → Domain Admin en < 1 h**

```
j.dupont (compte standard)
    │
    ├── [A3] dig AXFR → cartographie complète secuvia.local   (200 ms)
    │
    ├── [A1] GetUserSPNs → 3 hash TGS → hashcat               (15 min)
    │         └── svc_sql / svc_iis / svc_backup compromis
    │
    └── [A2] certipy req -template VulnTemplate
              -upn administrator@secuvia.local                 (5 min)
              └── TGT Administrator → dcsync → NTDS complet
```

<span class="crit">Aucune détection possible : A5 — pas de SIEM.</span>

→ **3 vulns exploitables depuis un seul poste** · **4 vulns si on compte A4 (Helpdesk→DA)** · **5 si on compte A5 (absence de journalisation)**.

---

<!-- Slide 5 — A1 Kerberoasting (Adam — 2 min) -->

# A1 — Kerberoasting · CVSS **8.1** · <span class="crit">ÉLEVÉE</span>

## BEFORE

`audit/before-adam/kerberoast/getting-spn-users-hashes.png`

```bash
$ GetUserSPNs.py secuvia.local/j.dupont -request -dc-ip 10.10.10.10
[+] svc_sql     $krb5tgs$23$*svc_sql$SECUVIA.LOCAL$...
[+] svc_iis     $krb5tgs$23$*svc_iis$SECUVIA.LOCAL$...
[+] svc_backup  $krb5tgs$23$*svc_backup$SECUVIA.LOCAL$...
```

`svc_sql_hash_cracked.png` → **`Summer2024!` cassé en 3 min 47 s**.

## AFTER — **R1 : rotation + GMSA + AES256-only**

```powershell
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))
New-ADServiceAccount -Name svc_sql_gmsa -DNSHostName dc01.secuvia.local
Set-ADUser svc_sql -KerberosEncryptionType AES128,AES256
```

→ Rejeu `GetUserSPNs` : **0 hash RC4**. Risque R-01 : <span class="warn">20 → 8</span>.

---

<!-- Slide 6 — A2 ADCS ESC1 (Adam — 2 min) -->

# A2 — ADCS ESC1 · CVSS **8.8** · <span class="crit">ÉLEVÉE</span>

## BEFORE

Template `VulnTemplate` avec `ENROLLEE_SUPPLIES_SUBJECT` + `Authenticated Users` + EKU `Client Authentication`.

`audit/before-adam/esc1/esc1-exploited.png`

```bash
$ certipy req -u j.dupont@secuvia.local -p ... \
    -template VulnTemplate -upn administrator@secuvia.local
[+] Saved certificate and private key to 'administrator.pfx'
```

→ TGT de `Administrator` obtenu → DCSync → NTDS.dit exfiltré.

## AFTER — **R4 : template durci**

```powershell
Remove-CATemplate -Name "VulnTemplate"
certutil -SetCATemplates -DomainControllerAuthentication,Computer
```

`remediation/after-adam/certipy/` → `certipy find -vulnerable` = **liste vide**. Risque R-02 : <span class="warn">20 → 5</span>.

---

<!-- Slide 7 — A3 DNS AXFR (Dhaker — 1 min) -->

# A3 — Transfert de zone DNS · CVSS **7.5** · <span class="crit">ÉLEVÉE</span>

## BEFORE

`audit/before-dhaker/03-audit-dns-axfr/axfr-success.png`

```bash
$ dig AXFR secuvia.local @10.10.10.10
;; Answer: 87 records
; Transfer complete (7421 bytes, 198 ms)
```

→ Cartographie complète du SI exfiltrée **sans authentification**.

## AFTER — **R3 : SecureSecondaries = TransferToSecureServers**

```powershell
Set-DnsServerPrimaryZone -Name "secuvia.local" `
    -SecureSecondaries TransferToSecureServers
```

`remediation/after-dhaker/kali/dns/dig_axfr_after.txt` :
```
;; communications error to 10.10.10.10#53: end of file
; Transfer failed.
```

→ Risque R-03 : <span class="warn">15 → 3</span>. **Éliminé.**

---

<!-- Slide 8 — SIEM ELK R5 (Dhaker — 2 min) -->

# A5 → R5 — **SIEM ELK opérationnel**

**Pile** : Elasticsearch 8.13 + Kibana 8.13 + Logstash + Winlogbeat (docker-compose).
**Source** : DC01 → `winlogbeat-*` sur index Elasticsearch.

| Événement AD | Capture de preuve | Détection |
|---|---|:---:|
| 4768 — TGT request | `after/centralisation-logs/demande-tgt-4768.png` | ✅ |
| 4769 — TGS request | `after/centralisation-logs/demande-tgs-4769.png` | ✅ |
| 4776 — NTLM auth | `after/centralisation-logs/validation-identifiants-4776.png` | ✅ |
| Winlogbeat flux | `after/centralisation-logs/winlogbeat-established-connection.png` | ✅ |

**Règle Sigma bonus** : `sigma_kerberoast.yml` — détecte `EventID=4769 + TicketEncryptionType=0x17` (RC4).

→ Un Kerberoasting rejoué **génère une alerte Kibana en moins de 5 minutes**.

---

<!-- Slide 9 — Registre + Plan 90j (Dhaker — 2 min) -->

# Registre des risques · Plan à 90 jours

**Fichier** : `xlsx/registre-risques-secuvia.xlsx` — 5 onglets, 10 risques cotés.

## Cotation : **167/250 → 76/250 (-55 %)**

| Horizon | Actions | Charge | Coût (TJM 650 €) |
|---|:-:|:-:|:-:|
| Quick Wins (J+0 → J+15) | 15 | 10 j-h | 6 500 € |
| Moyen Terme (J+16 → J+45) | 12 | 12 j-h | 7 800 € |
| Consolidation (J+46 → J+90) | 9 | 5 j-h | 3 250 € |
| **Total** | **36** | **27 j-h** | **17 550 €** |

**Top 3 Quick Wins** : finaliser R2 (LDAPS) J+1 · GPO tiering complet J+3 · désactiver SMBv1 + NetBIOS J+5.
**Aucun achat de licence** — tout repose sur le socle possédé (WS2022 + ADCS + ELK open-source).

---

<!-- Slide 10 — Conclusion (Adam — 2 min) -->

# Conclusion · Risques résiduels · Questions

## Ce que Secuvia a gagné en 48 h

- <span class="ok">5 vulnérabilités majeures détectées, scorées, documentées.</span>
- <span class="ok">6 remédiations livrées (5 ✅ + 1 ⚠️ partielle : R2 LDAPS).</span>
- <span class="ok">Socle SIEM opérationnel + 1 règle Sigma + 36 actions au plan 90j.</span>

## Ce qui reste à faire

- <span class="warn">R2 : liaison cert NTDS sur port 636 — 30 min, J+1.</span>
- <span class="warn">R-10 (MFA comptes privilégiés) — accepté temporairement, Q3 2026.</span>
- <span class="warn">Tiering complet (GPO d'isolation T0/T1/T2) — J+3.</span>

## Note auto-évaluée : **67/105** · Cible post-R2 : **80/105**

<br>

> **Merci — questions ?**
> `rapport/rapport-secuvia-4syse.pdf` · `xlsx/registre-risques-secuvia.xlsx` · [GitHub](#)
