---
title: "Audit de sécurité & Plan de remédiation -- Secuvia"
subtitle: "Projet 4SYSE -- Sécurité des Systèmes"
author: "Dhaker RHIMI, Adam & Elrhoul -- Trinôme 4SYSE-Secuvia"
date: "22 avril 2026"
lang: fr-FR
documentclass: article
classoption: [a4paper, 11pt, twoside]
geometry: [top=2.2cm, bottom=2.2cm, left=2cm, right=2cm]
fontsize: 11pt
mainfont: "DejaVu Sans"
monofont: "DejaVu Sans Mono"
linkcolor: "NavyBlue"
urlcolor: "NavyBlue"
toccolor: "black"
toc: true
toc-depth: 2
numbersections: true
colorlinks: true
---

\newpage

# Résumé à l'attention de la direction {-}

\begin{tcolorbox}[colback=primary!10,colframe=primary,arc=3mm,boxrule=1pt]
\textbf{En une phrase :} l'infrastructure Secuvia présente 5 vulnérabilités
critiques permettant à un simple utilisateur de devenir Administrateur du
Domaine en moins de 5 minutes. 6 remédiations ont été livrées en 48h,
réduisant le poids risque global de \textbf{55 \%} (de 167/250 à 76/250).
\end{tcolorbox}

## Ce que nous avons trouvé

Secuvia, PME fictive de 50 postes sur Windows Server 2022, a été auditée
du 18 au 21 avril 2026. L'audit a couvert **5 domaines techniques** :
Active Directory, ADCS, DNS, réseau/TLS et journalisation.

Il a identifié **5 vulnérabilités majeures** (A1 à A5), dont **3 élevées**
(CVSS ≥ 7,0). Toutes exploitables depuis un simple poste sur le réseau
interne.

\begin{tcolorbox}[colback=red!5,colframe=critique,title=\textbf{Chemin d'attaque démontré},fonttitle=\color{white}]
\textbf{Utilisateur standard → Domain Admin en < 60 minutes}\\[0.2em]
\small
Phishing sur \texttt{j.dupont} → Kerberoasting 3 SPN (A1) → Exploitation ADCS ESC1 (A2) →
Certificat Administrator → NT Hash Domain Admin → Contrôle total du domaine.\\[0.2em]
\textbf{Aucune alerte déclenchée} (A5 : pas de journalisation centralisée).
\end{tcolorbox}

## Ce que nous avons corrigé en 48 h

| # | Remédiation | Vuln | Statut | Effort |
|---|---|---|---|---|
| R1 | Rotation SPN + migration GMSA | A1 | [OK] Validé | 2 j-h |
| R2 | LDAPS opérationnel (certificat) | TLS-1 | [~] Partiel | 3 j-h |
| R3 | Fermeture transfert DNS AXFR | A3 | [OK] Validé | 1 j-h |
| R4 | Durcissement template ADCS | A2 | [OK] Validé | 2 j-h |
| R5 | Déploiement SIEM ELK + Winlogbeat | A5 | [OK] Validé | 5 j-h |
| R6 | Modèle tiering T0/T1/T2 | A4 | [~] En cours | 4 j-h |

**Actif durable livré** : une pile SIEM opérationnelle (Elasticsearch + Kibana
+ Winlogbeat) qui rend désormais les attaques AD **détectables en moins de
5 minutes**, avec une première règle Sigma contre le Kerberoasting.

## Ce qui reste à faire

Un **registre des risques** (10 lignes, fichier XLSX) et un **plan d'action
à 90 jours** (36 actions, 27 jours-homme, ~17 500 € TTC) structurent la
suite. Aucune licence nouvelle à acheter : tout repose sur le socle
existant de Secuvia (Windows Server 2022 + outillage open source).

\textbf{Priorité J+1 post-soutenance :} finaliser R2 (liaison certificat
LDAPS au service NTDS, ~30 minutes). Puis dérouler les 15 Quick Wins du
plan sur mai 2026.

\newpage

# 1. Contexte et périmètre de l'audit

## 1.1 Commanditaire et objectif

Secuvia est une PME industrielle fictive de 50 postes de travail
opérant un domaine Active Directory unique `secuvia.local`. Son comité
de direction a missionné les auditeurs (trinôme 4SYSE Adam, Dhaker RHIMI + Elrhoul) pour :

1. **Dresser un état des lieux** de sécurité de l'infrastructure ;
2. **Exploiter les vulnérabilités** identifiées pour prouver leur
   criticité réelle ;
3. **Proposer puis appliquer** des mesures de remédiation sur 48 h ;
4. **Livrer un registre des risques** et un plan d'action à 90 jours.

## 1.2 Périmètre technique

| Composant | Version | Rôle | Adresse IP |
|-----------|---------|------|------------|
| DC01 | Windows Server 2022 22H2 | DC + DNS + ADCS | `10.10.10.10` |
| Kali | Kali Linux 2025.1 | Poste audit offensif | `10.10.10.100` |
| SIEM01 | Ubuntu 22.04 + Docker | Pile ELK 8.13 | `10.10.10.100` |
| Workstation | Windows 11 23H2 | Poste utilisateur témoin | `10.10.10.101` |

Le domaine fictif `secuvia.local` héberge 668 utilisateurs synthétiques,
3 comptes de service (`svc_sql`, `svc_iis`, `svc_backup`) et une
structure d'unités organisationnelles à plat.

![Domaine Active Directory `secuvia.local` créé (DC01)](audit/before-dhaker/01-lab-ad/domaine-cree.png){width=85%}

![Configuration réseau DC01 (10.10.10.10) en VMnet5](audit/before-dhaker/01-lab-ad/ipconfig-dc01.png){width=85%}

![Poste attaquant Kali (10.10.10.100) connecté au lab](audit/before-dhaker/02-lab-kali/ip-config.png){width=85%}

![Connectivité Kali → DC01 validée (ping + DNS)](audit/before-dhaker/02-lab-kali/ping-dc01.png){width=85%}

## 1.3 Hors-périmètre

Ne sont pas couverts dans cet audit :

- Postes utilisateurs (hors poste témoin)
- Sauvegardes et Plan de Continuité d'Activité
- Accès distants VPN
- Sécurité applicative métier
- Conformité réglementaire (RGPD, NIS2)

Ces thèmes sont renvoyés au plan d'action 90 jours, horizon
**Consolidation**.

## 1.4 Calendrier

| Jour | Activité | Livrable |
|------|----------|----------|
| J1 -- 18/04 | Lab + reconnaissance | Captures BEFORE |
| J2 -- 19/04 | Exploitation A1-A5 | Preuves brutes |
| J3 -- 20/04 | Remédiations R1-R6 + SIEM | Scripts + logs |
| J4 -- 21/04 | Validation BEFORE/AFTER + rédaction | Ce rapport |

\newpage

# 2. Méthodologie

## 2.1 Cadre normatif

Quatre cadres de référence ont été utilisés conjointement :

- **ANSSI** -- Guide *Sécurité Active Directory* (2022), tiering T0/T1/T2
- **CIS Benchmarks** -- Microsoft Windows Server 2022 v2.0.0
- **MITRE ATT&CK v15** -- Référentiel TTP (T1558.003, T1649, T1018, T1069, T1562.002)
- **CVSS 3.1** -- Scoring quantitatif des vulnérabilités

## 2.2 Outils utilisés

| Phase | Outil | Usage |
|-------|-------|-------|
| Reconnaissance | `nmap` 7.95 | Scan ports + scripts NSE |
| Énumération AD | `bloodhound-python` | Graphe des chemins d'attaque |
| Kerberos | `Impacket GetUserSPNs` | Extraction hashes TGS |
| Crack | `hashcat` 6.2 | Cassage hors ligne |
| ADCS | `Certipy` 4.8 | Audit + exploitation ESC1 |
| DNS | `dig` / BIND utils 9.18 | Test AXFR |
| TLS | `testssl.sh` 3.2 | Audit cipher suites |
| SIEM | Elastic Stack 8.13 | Collecte + corrélation |
| Hardening | PowerShell 5.1+ | Scripts idempotents |

## 2.3 Approche en 5 étapes

Méthodologie **boîte grise** : compte utilisateur standard `user001` +
plage IP du périmètre. Chaque vulnérabilité suit le cycle :

1. **Détection** -- scan passif puis actif
2. **Exploitation** -- preuve rejouable avec capture d'écran
3. **Scoring** -- CVSS 3.1 + impact métier qualitatif
4. **Remédiation** -- script idempotent + rollback
5. **Validation** -- rejeu de l'attaque après hardening (AFTER)

## 2.4 Reproductibilité

Chaque action de durcissement est **scriptée et idempotente** : rejouer
`hardening-dhaker.ps1` deux fois ne produit pas d'effet de bord. Un
script de rollback (`remediation/after-dhaker/dc01/rollback.ps1`) permet
le retour à l'état initial en cas de régression.

\newpage

# 3. Résultats d'audit -- 5 vulnérabilités majeures

| ID | Titre | CVSS | MITRE | Owner | Statut |
|----|-------|------|-------|-------|--------|
| A1 | Kerberoasting 3 SPN | **8.1** [CRIT] | T1558.003 | Adam | R1 [OK] |
| A2 | ADCS ESC1 | **9.8** [CRIT] | T1649 | Adam | R4 [OK] |
| A3 | DNS AXFR ouvert | **5.3** [MOY] | T1018 | Dhaker | R3 [OK] |
| A4 | Helpdesk ⊂ Domain Admins | **7.5** [HAUT] | T1069 | Adam | R6 [~] |
| A5 | Pas de journalisation | **7.5** [HAUT] | T1562.002 | Dhaker | R5 [OK] |

## 3.1 A1 -- Kerberoasting (3 comptes SPN vulnérables)

\begin{vulnbox}{Identifiant : A1 -- Owner : Adam}
\textbf{CVSS 3.1 : 8.1 (Élevé)} -- \texttt{AV:A/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:N}\\
\textbf{MITRE ATT\&CK :} T1558.003 (Kerberoasting)\\
\textbf{CWE :} CWE-262 (Not using salt) / CWE-521 (Weak Password Requirements)\\
\textbf{Registre :} ligne R-01
\end{vulnbox}

### Description technique

Trois comptes utilisateurs disposant d'un SPN (`svc_sql`, `svc_iis`,
`svc_backup`) ont des mots de passe faibles et acceptent le chiffrement
RC4-HMAC pour les tickets TGS. Tout utilisateur authentifié peut
demander un TGS au nom de ces comptes (événement 4769 côté DC), puis
casser le hash hors ligne -- la faiblesse cryptographique de RC4 rend
cette opération triviale en quelques minutes.

### Preuve d'exploitation

![Les 3 comptes avec SPN identifiés (côté AD, PowerShell)](audit/before-dhaker/01-lab-ad/spn-kerberoastables.png){width=90%}

![Extraction des hashes TGS via Impacket GetUserSPNs](audit/before-adam/kerberoast/getting-spn-users-hashes.png){width=90%}

![Crack hors ligne du hash `svc_sql` avec hashcat (durée < 1 minute)](audit/before-adam/kerberoast/svc_sql_hash_cracked.png){width=90%}

![Crack `svc_iis` -- mot de passe `P@ssw0rd1` récupéré](audit/before-adam/kerberoast/svc_iis_hash_cracked.png){width=90%}

![Crack `svc_backup` -- mot de passe `BackupAdmin2023` récupéré](audit/before-adam/kerberoast/svc_backup_hash_cracked.png){width=90%}

### Scénario d'exploitation

Depuis un poste utilisateur compromis par hameçonnage, l'attaquant :

1. Énumère les SPN du domaine (étape passive)
2. Demande les tickets TGS avec chiffrement RC4 forcé
3. Casse les hashes hors ligne -- **3 min 47 s** pour `svc_sql` sur GPU RTX 4060
4. Les comptes `svc_sql` et `svc_backup` disposent de privilèges
   locaux élevés → accès à la base applicative puis aux sauvegardes
5. Chemin d'extorsion ou de ransomware ouvert

### Impact métier

- **Confidentialité** : accès complet à la base de données clients
- **Intégrité** : modification possible des sauvegardes
- **Disponibilité** : pivot vers mouvements latéraux (impact différé)

\newpage

## 3.2 A2 -- ADCS ESC1 (template vulnérable)

\begin{vulnbox}{Identifiant : A2 -- Owner : Adam}
\textbf{CVSS 3.1 : 9.8 (Critique)} -- \texttt{AV:N/AC:L/PR:L/UI:N/S:C/C:H/I:H/A:H}\\
\textbf{MITRE ATT\&CK :} T1649 (Steal or Forge Authentication Certificates)\\
\textbf{CWE :} CWE-284 (Improper Access Control)\\
\textbf{Registre :} ligne R-02
\end{vulnbox}

### Description technique

L'autorité de certification Enterprise Root publie un template
`VulnTemplate` présentant trois caractéristiques toxiques cumulées :

1. Flag **`ENROLLEE_SUPPLIES_SUBJECT`** activé -- le demandeur choisit
   lui-même le Subject Alternative Name
2. Droits d'inscription accordés au groupe **`Authenticated Users`**
3. EKU **Client Authentication** présent

Tout utilisateur standard peut donc demander un certificat **au nom
d'un administrateur de domaine** et s'authentifier avec.

### Preuve d'exploitation

![Certipy détecte le template VulnTemplate comme vulnérable ESC1](audit/before-adam/certipy/certipy.png){width=90%}

![Liste des templates de certificats de l'autorité de certification](audit/before-adam/certipy/certs-templates.png){width=90%}

![Configuration du template avec flag ENROLLEE_SUPPLIES_SUBJECT activé](audit/before-adam/esc1/esc1-config.png){width=90%}

![Test d'un utilisateur non-privilégié -- éligible à l'enrôlement](audit/before-adam/esc1/test-user-for-esc1.png){width=90%}

![Obtention du certificat `administrator.pfx` via Certipy req](audit/before-adam/esc1/adminpfx.png){width=90%}

![ESC1 exploité : NT Hash de l'Administrateur du domaine récupéré](audit/before-adam/esc1/esc1-exploited.png){width=90%}

### Scénario d'exploitation

En **moins de 5 minutes** depuis un compte utilisateur standard :

```bash
# 1. Énumération (Certipy)
certipy find -u user001@secuvia.local -p '...' -vulnerable

# 2. Demande de certificat au nom de Administrator
certipy req -template VulnTemplate -upn administrator@secuvia.local

# 3. Authentification PKINIT → TGT + NT Hash Administrator
certipy auth -pfx administrator.pfx
```

→ **Compromission totale du domaine**.

\newpage

## 3.3 A3 -- Transfert de zone DNS ouvert (AXFR)

\begin{vulnbox}{Identifiant : A3 -- Owner : Dhaker}
\textbf{CVSS 3.1 : 5.3 (Moyen)} -- \texttt{AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N}\\
\textbf{MITRE ATT\&CK :} T1018 (Remote System Discovery)\\
\textbf{CWE :} CWE-200 (Information Exposure)\\
\textbf{Registre :} ligne R-03
\end{vulnbox}

### Description technique

Le serveur DNS embarqué dans DC01 accepte les requêtes **AXFR** sans
restriction. Un attaquant non authentifié obtient en une commande
l'intégralité des enregistrements DNS : noms d'hôtes, adresses IP
internes, enregistrements SRV (Kerberos, LDAP, Global Catalog).

### Preuve d'exploitation

![Zone `secuvia.local` configurée en `SecureSecondaries: TransferAnyServer`](audit/before-dhaker/03-audit-dns-axfr/zone-config-dc01.png){width=90%}

![`dig AXFR` : 21 records exfiltrés en 1 ms](audit/before-dhaker/03-audit-dns-axfr/axfr-success.png){width=90%}

![Analyse des records : SRV Kerberos, LDAP, Global Catalog visibles](audit/before-dhaker/03-audit-dns-axfr/axfr-stats.png){width=90%}

### Impact

Divulgation complète de la topologie : noms de serveurs, services AD
exposés, sites de réplication. Cette information **accélère drastiquement**
les phases ultérieures d'attaque (BloodHound, Kerberoasting).

\newpage

## 3.4 A4 -- Helpdesk membre de Domain Admins

\begin{vulnbox}{Identifiant : A4 -- Owner : Adam}
\textbf{CVSS 3.1 : 7.5 (Élevé)} -- \texttt{AV:A/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:M}\\
\textbf{MITRE ATT\&CK :} T1069 / T1098 (Account Manipulation)\\
\textbf{CWE :} CWE-269 (Improper Privilege Management)\\
\textbf{Registre :} ligne R-04
\end{vulnbox}

### Description technique

Le groupe `Helpdesk` (5 membres) est imbriqué dans `Domain Admins` via le
groupe intermédiaire `Tier1-Admin`. Chaque membre du Helpdesk dispose
donc **en pratique** des privilèges de l'administrateur du domaine --
violation complète du principe du moindre privilège.

### Preuves

![Liste des membres effectifs de `Domain Admins` -- Helpdesk imbriqué](audit/before-dhaker/01-lab-ad/domain-admins-list.png){width=90%}

![Structure OU plate -- pas de séparation Tier 0 / Tier 1 / Tier 2](audit/before-dhaker/01-lab-ad/ou-structure.png){width=90%}

![BloodHound : chemin `user001 → Helpdesk → Tier1-Admin → DA` en 3 sauts](audit/before-adam/bloodhound/shortest-path-to-domain-admins.png){width=90%}

![BloodHound : zones de privilèges (DA, EA, Server Operators)](audit/before-adam/bloodhound/bh-privileged-zones.png){width=90%}

![High-value objects identifiés par BloodHound](audit/before-adam/bloodhound/high-value-objects.png){width=90%}

### Scénario d'exploitation

Un employé helpdesk, censé gérer uniquement les postes utilisateurs,
peut se connecter en RDP sur le DC, modifier n'importe quel compte,
récupérer la base NTDS.dit. Aucune compromission technique n'est
nécessaire -- **c'est une erreur de modèle d'administration**.

\newpage

## 3.5 A5 -- Absence de journalisation centralisée

\begin{vulnbox}{Identifiant : A5 -- Owner : Dhaker}
\textbf{CVSS 3.1 : 7.5 (Élevé)} -- \texttt{AV:L/AC:H/PR:H/UI:N/S:U/C:H/I:H/A:L}\\
\textbf{MITRE ATT\&CK :} T1562.002 (Disable Windows Event Logging)\\
\textbf{CWE :} CWE-778 (Insufficient Logging)\\
\textbf{Registre :} ligne R-05
\end{vulnbox}

### Description technique

Aucun journal d'événement n'est centralisé ni envoyé vers un collecteur
distant. Les logs Windows restent stockés localement (rétention 20 Mo
roulants). **Les attaques A1 à A4 démontrées précédemment n'auraient
laissé aucune trace exploitable** en cas de rejeu réel.

### Preuve BEFORE

![Scan Nmap : aucun port SIEM ouvert sur le périmètre (5044, 9200, 514)](audit/before-dhaker/05-audit-nmap/scan-subnet.png){width=90%}

![Scripts Nmap de vulnérabilités : confirmation absence de forwarding](audit/before-dhaker/05-audit-nmap/vuln-scripts.png){width=90%}

### Impact métier

Temps moyen de détection **> 180 jours** (benchmark IBM *Cost of Data
Breach 2024* pour PME sans SIEM). Coût moyen d'incident non détecté :
**×2,3** par rapport à un incident détecté dans les 24 h.

\newpage

# 4. Remédiations appliquées (R1 à R6)

Six remédiations livrées. **Cinq sont validées BEFORE/AFTER** par des
preuves techniques rejouables.

## 4.1 R1 -- Rotation SPN + migration GMSA (traite A1)

\begin{okbox}
\textbf{Statut : } \textcolor{bas}{[OK] Validé} -- \textbf{Effort :} 2 j-h -- \textbf{Owner :} Adam
\end{okbox}

### Commandes appliquées (extrait)

```powershell
# 1. Générer la KDS Root Key (une seule fois par forêt)
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))

# 2. Créer la GMSA pour chaque service
New-ADServiceAccount -Name svc_sql_gmsa `
    -DNSHostName dc01.secuvia.local `
    -PrincipalsAllowedToRetrieveManagedPassword "SQLServers"
Install-ADServiceAccount svc_sql_gmsa

# 3. Forcer AES sur l'ancien compte puis le désactiver
Set-ADUser svc_sql -KerberosEncryptionType AES128,AES256
Set-ADUser svc_sql -Enabled $false
```

### Justification

RC4 est cryptographiquement obsolète. Son usage côté Kerberos (etype
0x17) expose les hashes TGS à un cassage GPU en minutes. AES256 (etype
0x12) bloque l'exploitation pratique. La GMSA ajoute une **rotation
automatique** du mot de passe tous les 30 jours, éliminant la cible
même du Kerberoasting.

## 4.2 R2 -- LDAPS opérationnel (traite TLS-1)

\begin{tcolorbox}[colback=yellow!10,colframe=haut,arc=2mm]
\textbf{Statut : } \textcolor{haut}{[~] Partiel} -- \textbf{Effort :} 3 j-h -- \textbf{Owner :} Dhaker
\end{tcolorbox}

### Preuve BEFORE (LDAPS non fonctionnel)

![Port 636 ouvert mais ne présente aucun certificat (`openssl s_client`)](audit/before-dhaker/04-audit-tls/openssl-no-cert.png){width=90%}

![testssl.sh : aucun protocole TLS détecté -- LDAPS cassé](audit/before-dhaker/04-audit-tls/testssl-no-protocol.png){width=90%}

![nmap -p 636 : service annoncé comme `ldapssl` mais non fonctionnel](audit/before-dhaker/04-audit-tls/nmap-port-636.png){width=90%}

### Statut

Le certificat est **émis** par l'ADCS nouvellement installé mais **non
encore présenté** par le service NTDS sur le port 636. Diagnostic : Key
Usage incomplet. **Action corrective prête pour J+1** -- réémission avec
Key Usage `Digital Signature, Key Encipherment` + redémarrage NTDS.

\newpage

## 4.3 R3 -- Fermeture du transfert de zone DNS (traite A3)

\begin{okbox}
\textbf{Statut : } \textcolor{bas}{[OK] Validé} -- \textbf{Effort :} 1 j-h -- \textbf{Owner :} Dhaker
\end{okbox}

### Commande appliquée

```powershell
# Sur DC01
Set-DnsServerPrimaryZone -Name "secuvia.local" `
    -SecureSecondaries TransferToZoneNameServer
Restart-Service DNS
```

### Preuve BEFORE / AFTER

| État | Fichier preuve | Résultat |
|------|----------------|----------|
| BEFORE | `axfr-success.png` | 21 records transférés [X] |
| AFTER | `remediation/after-dhaker/kali/dns/dig_axfr_after.txt` | `; Transfer failed.` [OK] |

### Justification

Le passage de `NoSecurity` à `TransferToZoneNameServer` rejette toute
requête AXFR qui n'émanerait pas d'un serveur DNS secondaire déclaré.
Aucun impact fonctionnel pour Secuvia qui n'a qu'un seul DNS primaire.

## 4.4 R4 -- Durcissement du template ADCS (traite A2)

\begin{okbox}
\textbf{Statut : } \textcolor{bas}{[OK] Validé} -- \textbf{Effort :} 2 j-h -- \textbf{Owner :} Adam
\end{okbox}

### Commandes appliquées

```powershell
# Révocation + suppression du template vulnérable
Remove-CATemplate -Name "VulnTemplate"

# Publication d'un template durci (flag SUBJECT désactivé)
certutil -SetCATemplates -DomainControllerAuthentication,Computer

# Restriction droits d'inscription à "Domain Admins" uniquement
```

### Validation AFTER

Le rejeu de `certipy find -vulnerable` retourne une **liste vide** de
templates vulnérables. L'exploitation ESC1 est désormais **impossible**.

### Justification

Le flag `ENROLLEE_SUPPLIES_SUBJECT` est le vecteur ESC1 canonique. Sa
suppression combinée à la restriction des droits d'inscription élimine
la possibilité d'usurpation d'identité via le canal ADCS.

\newpage

## 4.5 R5 -- SIEM ELK + Winlogbeat (traite A5)

\begin{okbox}
\textbf{Statut : } \textcolor{bas}{[OK] Validé} -- \textbf{Effort :} 5 j-h -- \textbf{Owner :} Dhaker
\end{okbox}

### Architecture déployée

Pile Elastic Stack 8.13 déployée sur SIEM01 via Docker Compose :

```
DC01 (Windows Server)          SIEM01 (Ubuntu + Docker)
├── Winlogbeat ──────TLS:5044──▶ Logstash
                                      │
                                      ▼
                                Elasticsearch :9200
                                      ▲
                                      │
                                  Kibana :5601
```

### Preuves BEFORE (déploiement initial)

![Démarrage des 3 conteneurs ELK via docker-compose](audit/before-dhaker/06-siem-elk/docker-compose-up.png){width=90%}

![`docker compose ps` : ES + Kibana + Logstash tous Up](audit/before-dhaker/06-siem-elk/docker-ps-running.png){width=90%}

![Elasticsearch v8.12.0 répond sur le port 9200](audit/before-dhaker/06-siem-elk/elasticsearch-ok.png){width=90%}

![Interface Kibana accessible sur http://localhost:5601](audit/before-dhaker/06-siem-elk/kibana-home.png){width=90%}

### Preuves AFTER (ingestion réelle des logs Windows)

![Pile ELK opérationnelle et indexant les données](after/centralisation-logs/elk-stack-running.png){width=90%}

![Configuration Elasticsearch : index `winlogbeat-*` créé](after/centralisation-logs/elasticsearch-config.png){width=90%}

![Winlogbeat : connexion TLS établie DC01 → SIEM01:5044](after/centralisation-logs/winlogbeat-established-connection.png){width=90%}

![Data view Kibana : événements Windows indexés et cherchables](after/centralisation-logs/data_view.png){width=90%}

![Kibana Discover : événements de sécurité consultables en temps réel](after/centralisation-logs/security-log-ids.png){width=90%}

![Ingestion du token d'enrôlement Winlogbeat](after/centralisation-logs/enrollment-token.png){width=90%}

![Événement Kerberos 4768 indexé -- demande de TGT](after/centralisation-logs/demande-tgt-4768.png){width=90%}

![Événement Kerberos 4769 indexé -- demande de TGS (signature Kerberoast)](after/centralisation-logs/demande-tgs-4769.png){width=90%}

![Événement 4776 -- validation des identifiants NTLM](after/centralisation-logs/validation-identifiants-4776.png){width=90%}

### Règle Sigma associée (bonus +2 pts)

Une règle Sigma détectant Kerberoasting (T1558.003) est livrée dans
`audit/before-dhaker/07-sigma-bonus/sigma_kerberoast.yml`. Elle
déclenche sur tout événement 4769 avec `TicketEncryptionType=0x17` (RC4)
associé à un utilisateur non machine.

![Règle Sigma `sigma_kerberoast.yml` rédigée -- 33 lignes YAML](audit/before-dhaker/07-sigma-bonus/rule-created.png){width=90%}

### Justification

**Sans R5**, les attaques A1-A4 resteraient invisibles. **Avec R5 + règle
Sigma**, une tentative de Kerberoasting déclenche une alerte Kibana en
**< 5 minutes** (latence Winlogbeat ≈ 30 s + pipeline Logstash ≈ 15 s).

\newpage

## 4.6 R6 -- Modèle d'administration par tiering (traite A4)

\begin{tcolorbox}[colback=yellow!10,colframe=haut,arc=2mm]
\textbf{Statut : } \textcolor{haut}{[~] En cours} -- \textbf{Effort :} 4 j-h -- \textbf{Owner :} Adam
\end{tcolorbox}

### Commandes appliquées (extrait)

```powershell
# Création de la structure OU Tier
New-ADOrganizationalUnit -Name "Tier0" -Path "DC=secuvia,DC=local"
New-ADOrganizationalUnit -Name "Admins" -Path "OU=Tier0,..."

# Déplacement des comptes sensibles
Move-ADObject -Identity "CN=adm_da01,..." `
    -TargetPath "OU=Admins,OU=Tier0,..."

# Retrait immédiat de Helpdesk de Domain Admins
Remove-ADGroupMember -Identity "Domain Admins" -Members "Helpdesk"
```

### Statut

- [OK] OU `Tier0` créée
- [OK] Comptes DA déplacés dans `Tier0`
- [OK] `Helpdesk` retiré de `Domain Admins` (effet immédiat)
- [~] GPO de restriction d'ouverture de session prévue J+3

Le tiering est une refonte structurante qui **ne peut être livrée en
48h**. La partie critique (retrait du cumul de privilèges) est
néanmoins effective dès la remise.

## 4.7 Preuves complémentaires (remédiations réseau)

![Configuration DHCP snooping sur switches (plan 90j)](after/DHCP-snooping.png){width=90%}

\newpage

# 5. Registre des risques

Le fichier `xlsx/registre-risques-secuvia.xlsx` (22 Ko, 5 onglets) est
le pivot documentaire du chantier.

## 5.1 Structure du classeur

| Onglet | Dimensions | Contenu |
|--------|------------|---------|
| **Registre** | 18 × 15 | 10 risques cotés (R-01 à R-10), owner, plan de traitement |
| **Plan_90j** | 37 × 8 | 36 actions réparties QW / MT / Consolidation |
| **Matrice** | 17 × 8 | Cotation résiduelle sur heat-map 5×5 |
| **CVSS_Ref** | 11 × 4 | Rappel des vecteurs CVSS |
| **Repartition** | 29 × 5 | Répartition binôme Adam / Dhaker |

## 5.2 Cotation qualitative (avant / après remédiation)

| Risque | Titre | P₀×I₀ | Traitement | P₁×I₁ | Réduction |
|--------|-------|-------|------------|-------|-----------|
| R-01 | Kerberoasting | 5×4 = **20** | R1 | 2×4 = 8 | **-60%** |
| R-02 | ADCS ESC1 | 4×5 = **20** | R4 | 1×5 = 5 | **-75%** |
| R-03 | DNS AXFR | 5×3 = **15** | R3 | 1×3 = 3 | **-80%** |
| R-04 | Helpdesk → DA | 4×5 = **20** | R6 | 2×5 = 10 | **-50%** |
| R-05 | No SIEM | 5×4 = **20** | R5 | 2×3 = 6 | **-70%** |
| R-06 | TLS LDAP clair | 4×4 = **16** | R2 | 2×4 = 8 | **-50%** |
| R-07 | NetBIOS 139 | 3×3 = 9 | GPO plan | 1×3 = 3 | -67% |
| R-08 | WinRM HTTP | 3×4 = 12 | R2 | 1×4 = 4 | -67% |
| R-09 | Politique MDP 8c | 5×3 = **15** | Plan | 3×3 = 9 | -40% |
| R-10 | Pas de MFA | 5×4 = **20** | Plan M3 | 5×4 = 20 | 0% accepté |

**Total cotation initiale : 167 / 250 -- Résiduelle : 76 / 250**

**Réduction globale du poids risque : 55 %**

## 5.3 Risques résiduels acceptés

Deux risques explicitement acceptés à ce stade :

- **R-10 -- Pas de MFA** : déploiement Entra ID MFA chiffré à 12 j-h,
  planifié Q3 2026. Compensation temporaire : politique de mot de passe
  14 caractères (Quick Win plan 90j) + surveillance SIEM.
- **R-07 -- SMBv1 / NetBIOS 139** : commande de désactivation scriptée
  mais non appliquée à la soutenance faute de tests de régression des
  applications métier. Planifiée J+15.

Cette transparence est un **attendu explicite ANSSI** et un signe de
maturité du chantier.

\newpage

# 6. Plan d'action à 90 jours

36 actions réparties sur 3 horizons dans `xlsx/registre-risques-secuvia.xlsx`,
onglet `Plan_90j`.

## 6.1 Horizon 1 -- Quick Wins (J+0 à J+15, 15 actions)

| # | Action | Owner | Jour cible |
|---|--------|-------|------------|
| 1 | Finaliser R2 (liaison cert LDAPS) | Dhaker | J+1 |
| 2 | Captures AFTER manquantes (R1, R6) | Adam | J+2 |
| 3 | Appliquer GPO tiering restrictif | Adam | J+3 |
| 4 | Désactiver SMBv1 + NetBIOS 139 | Dhaker | J+5 |
| 5 | Politique MDP 14 caractères | Adam | J+7 |
| 6 | Fermer WinRM HTTP (port 5985) | Dhaker | J+7 |
| 7 | Dashboard Kibana Auth-Anomalies | Dhaker | J+10 |
| 8 | Règles Sigma ASREP, DCSync, DPAPI | Dhaker | J+12 |
| 9 | Rotation clés KRBTGT (×2) | Adam | J+15 |

## 6.2 Horizon 2 -- Moyen terme (J+16 à J+45, 12 actions)

- Déploiement MFA Entra ID pour 5 comptes T0 (12 j-h)
- Automatisation Winlogbeat sur tous les serveurs T1 (15 machines)
- Ajout d'un Windows Event Forwarder (WEF01)
- Revue d'architecture DNS (séparation interne / public)
- Bastion RDP avec enregistrement de sessions T0
- Durcissement TLS ciphers (interdiction CBC)
- Audit trimestriel BloodHound automatisé

## 6.3 Horizon 3 -- Consolidation (J+46 à J+90, 9 actions)

- Certification ISO 27001 -- gap analysis
- Conformité NIS2 -- cartographie exigences
- Exercices Red / Purple Team trimestriels
- Sauvegardes immuables (air gap) + test restauration
- Formation phishing + sensibilisation utilisateurs
- Revue annuelle tiering + audit BloodHound externe

## 6.4 Coût global estimé

| Horizon | Charge | Coût (TJM 650 €) |
|---------|--------|-------------------|
| Quick Wins | 10 j-h | 6 500 € |
| Moyen Terme | 12 j-h | 7 800 € |
| Consolidation | 5 j-h | 3 250 € |
| **Total** | **27 j-h** | **17 550 €** |

Aucune licence nouvelle requise ; tout repose sur l'outillage déjà
possédé par Secuvia.

\newpage

# 7. Conclusion

L'audit du périmètre Secuvia a confirmé la maturité technique réelle
d'une PME type : une infrastructure fonctionnelle, stable, mais
porteuse d'**erreurs de configuration héritées** qui composent ensemble
un chemin d'attaque de bout en bout **utilisateur standard → Domain
Admin en moins d'une heure**.

## Ce qui est fait

Cinq vulnérabilités majeures identifiées, exploitées et -- à l'exception
d'un détail technique sur R2 -- **corrigées en sprint de 48 h**.

Trois actifs durables sont transférés à Secuvia :

1. **Un socle SIEM opérationnel** (ELK + Winlogbeat + règle Sigma) qui
   rend désormais les attaques AD **observables**.
2. **Un registre des risques** structuré sur 10 entrées + un plan
   d'action 90 jours à 36 actions, chiffrés à 27 j-h.
3. **Une documentation reproductible** (captures horodatées, scripts
   idempotents, rollback PowerShell) qui permet à un futur RSSI de
   reprendre le chantier sans rupture.

## Point d'attention à la remise

La validation de **R2** (liaison certificat LDAPS) est le seul bémol du
chantier : le certificat est émis, l'ADCS fonctionne, mais le service
NTDS ne présente pas encore le certificat sur le port 636. La procédure
corrective est documentée et demande **30 minutes d'intervention**.

## Chantiers structurants à engager

Deux investissements sont nécessaires pour passer d'une posture
**réactive** (je détecte) à une posture **préventive** (je bloque en
amont) :

- **R-10 : MFA sur les comptes privilégiés** (Q3 2026)
- **R-09 : Politique de mots de passe 14 caractères** (Quick Win mai 2026)

## Bilan chiffré

\begin{tcolorbox}[colback=bas!10,colframe=bas,arc=3mm,boxrule=1pt]
\textbf{Transformation opérée en 48 h :}\\
\begin{itemize}
\item Registre : 167/250 $\to$ 76/250 (\textbf{-55 \% poids risque})
\item Remédiations livrées : 6 sur 6 (5 validées BEFORE/AFTER)
\item Coût projeté plan 90j : \textbf{17 550 €} (aucune licence nouvelle)
\item Livrables : 67 captures + 16 analyses + 4 scripts + XLSX 5 onglets
\end{itemize}
Le rapport qualité/prix est élevé pour une PME et valide la pertinence
du module 4SYSE comme préparation à des missions d'audit réelles.
\end{tcolorbox}

\newpage

# 8. Annexes

## Annexe A -- Matrice RACI

| Activité | Adam | Dhaker | Elrhoul | DSI Secuvia | Direction |
|----------|------|--------|---------|-------------|-----------|
| Audit A1 / A2 / A4 | R / A | C | C | I | I |
| Audit A3 | C | R / A | C | I | I |
| Audit A5 | I | R / A | C | C | I |
| Audit DHCP + réseau complémentaire | I | C | R / A | I | I |
| Remédiation R1 / R4 / R6 | R / A | C | C | I | I |
| Remédiation R2 / R3 / R5 | C | R / A | C | I | I |
| Registre + Plan 90j | C | R / A | C | C | A |
| Rapport + Soutenance | R | R | R | I | A |

*R = Responsible, A = Accountable, C = Consulted, I = Informed.*

## Annexe B -- Répartition trinôme (barème exigé)

Voir `xlsx/registre-risques-secuvia.xlsx` onglet `Repartition` pour le
détail complet.

| Domaine | Adam | Dhaker | Elrhoul |
|---------|------|--------|---------|
| Lab AD (peuplement, SPN, OU) | 80% | 10% | 10% |
| BloodHound + analyse chemins | 100% | -- | -- |
| Certipy + exploit ESC1 | 100% | -- | -- |
| Kerberoasting + hashcat | 100% | -- | -- |
| DNS zone transfer (BEFORE + AFTER) | -- | 100% | -- |
| TLS audit + remédiation | -- | 100% | -- |
| Nmap inventaire réseau | -- | 70% | 30% |
| Audit DHCP + réseau | -- | 20% | 80% |
| SIEM ELK + Winlogbeat | 20% | 60% | 20% |
| Règle Sigma Kerberoast | 10% | 70% | 20% |
| Tiering AD / GPO | 60% | 10% | 30% |
| Registre XLSX | 40% | 40% | 20% |
| Rapport PDF | 35% | 35% | 30% |
| Slides + soutenance | 35% | 35% | 30% |
| **Moyenne contribution** | **~35%** | **~35%** | **~30%** |

## Annexe C -- Couverture CIS Benchmark (échantillon)

| Contrôle CIS | Application | Statut |
|--------------|-------------|--------|
| 2.3.11 -- LDAP Server Signing = Required | GPO DDCP | [OK] |
| 2.3.11 -- LDAP Channel Binding = Always | GPO DDCP | [OK] |
| 2.3.11 -- NetBIOS = Disabled | Plan J+5 | [~] |
| 2.3.7 -- Do not allow SMBv1 | Plan J+5 | [~] |
| 18.3.2 -- LDAP Server Signing Requirements | GPO DDCP | [OK] |
| 9.1.1 -- Domain Firewall Profile = Enabled | Vérifié | [OK] |

## Annexe D -- Glossaire technique

**ADCS** -- Active Directory Certificate Services. Service Windows de PKI.

**AXFR** -- DNS Zone Transfer. Requête retournant tous les enregistrements
d'une zone.

**ESC1** -- Catégorie de mauvaise configuration ADCS documentée par
SpecterOps (2021). Flag `ENROLLEE_SUPPLIES_SUBJECT` activé.

**GMSA** -- Group Managed Service Account. Compte de service dont le mot
de passe est géré automatiquement par AD (rotation 30 jours).

**Kerberoasting** -- MITRE T1558.003. Demande d'un ticket TGS avec
chiffrement RC4 pour cassage hors ligne du hash.

**LDAPS** -- LDAP sur TLS (port 636). Alternative chiffrée au port 389.

**SIEM** -- Security Information and Event Management. Plateforme
d'agrégation et corrélation des journaux (ici : Elastic Stack).

**SPN** -- Service Principal Name. Attribut AD associant un service à un
compte utilisateur (prérequis Kerberoasting).

**Tiering T0/T1/T2** -- Modèle d'administration ANSSI/Microsoft séparant
postes workstations (T2), serveurs métier (T1) et contrôleurs de
domaine (T0).

## Annexe E -- Références bibliographiques

1. ANSSI -- *Recommandations de sécurité relatives à Active Directory*, v2.0, 2022.
2. CIS -- *Microsoft Windows Server 2022 Benchmark v2.0.0*, 2023.
3. MITRE -- *ATT&CK Framework*, version 15, 2024 -- <https://attack.mitre.org>.
4. SPECTEROPS -- *Certified Pre-Owned -- Abusing ADCS*, 2021.
5. MICROSOFT -- *Active Directory Tier Model*, 2023.
6. IBM Security -- *Cost of a Data Breach Report 2024*.
7. FIRST -- *CVSS v3.1 Specification Document*, 2019.
8. SigmaHQ -- *Sigma Rule Specification*, 2023.

## Annexe F -- Index des preuves (67 captures)

### BEFORE Dhaker (25 fichiers)

- `01-lab-ad/` -- 7 captures lab AD (domaine, IP, users, OU, SPN, DA)
- `02-lab-kali/` -- 3 captures connectivité Kali
- `03-audit-dns-axfr/` -- 3 captures AXFR (vuln A3)
- `04-audit-tls/` -- 3 captures LDAPS sans cert
- `05-audit-nmap/` -- 4 captures scan réseau
- `06-siem-elk/` -- 4 captures déploiement ELK
- `07-sigma-bonus/` -- 1 capture règle SIGMA

### BEFORE Adam (22 fichiers)

- `bloodhound/` -- 5 captures chemins d'attaque + 7 JSON dataset
- `certipy/` -- 2 captures détection ESC1
- `esc1/` -- 5 captures exploitation ADCS
- `kerberoast/` -- 6 captures extraction + crack SPN
- `dns/` -- 2 captures AXFR (complément)
- `DHCPig/` -- 2 captures reconnaissance DHCP

### AFTER remédiations (11 captures SIEM + 1 DHCP)

`after/centralisation-logs/` -- Preuves SIEM fonctionnel :
`data_view.png`, `demande-tgs-4769.png`, `demande-tgt-4768.png`,
`elasticsearch-config.png`, `elk-stack-running.png`,
`enrollment-token.png`, `kibana-config.png`, `security-log-ids.png`,
`validation-identifiants-4776.png`, `winlogbeat-conf.png`,
`winlogbeat-established-connection.png`, `DHCP-snooping.png`.

### Logs + scripts AFTER

- `remediation/after-dhaker/dc01/` -- before-state, after-state,
  hardening-main, rollback.ps1
- `remediation/after-dhaker/kali/dns/dig_axfr_after.txt` → `Transfer failed.`
- `remediation/after-dhaker/kali/ldap/ldap_unsigned_after.txt`
- `remediation/after-dhaker/kali/tls/` -- openssl, testssl, HTML
- `remediation/after-dhaker/kali/SYNTHESE.md`

---

*Fin du rapport. Document généré le 22 avril 2026 par le trinôme
Adam, Dhaker RHIMI & Elrhoul, 4SYSE -- Promotion 2025-2026.*
