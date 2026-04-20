# peuplement-ad.ps1 — Script commun Adam & Dhaker

Script PowerShell idempotent qui peuple votre Active Directory Secuvia de
façon **identique** sur les deux labs.

## Prérequis (sur le DC01 de chaque lab)

- Windows Server 2022 installé.
- IP statique 10.10.10.10.
- Rôle AD DS installé et DC promu (`Install-ADDSForest`).
- Domaine `secuvia.local` créé.
- Se connecter en tant qu'administrateur du domaine.

## Utilisation

### 1. Récupérer le script depuis Git

Sur le DC01, ouvrir PowerShell en admin :

```powershell
# Option A : git clone (si Git pour Windows installé)
cd C:\
git clone https://github.com/<votre-user>/secuvia-4syse.git
cd secuvia-4syse\lab\scripts-adam

# Option B : copie manuelle du fichier via partage ou clipboard
```

### 2. Autoriser l'exécution (une seule fois)

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
```

### 3. Tester en DRY-RUN d'abord (aucune écriture)

```powershell
.\peuplement-ad.ps1 -DryRun -Verbose
```

Vous verrez toutes les actions qui seraient faites, sans rien créer.
Très utile pour vérifier que le domaine est bien détecté.

### 4. Lancer le peuplement réel

```powershell
.\peuplement-ad.ps1
```

Comptez **2 à 4 minutes** selon la puissance de la VM (création des 650 users
en boucle). Un indicateur de progression s'affiche tous les 5%.

### 5. Vérifier le résultat

```powershell
# Nombre d'utilisateurs dans l'OU
(Get-ADUser -Filter * -SearchBase "OU=Secuvia,DC=secuvia,DC=local").Count

# Les Domain Admins
Get-ADGroupMember "Domain Admins"

# Les SPN (cible kerberoast)
Get-ADUser -Filter {ServicePrincipalName -like "*"} -Properties ServicePrincipalName
```

## Ce que le script crée

| Élément | Quantité | Détails |
|---|---|---|
| OU `Secuvia` | 1 racine | Volontairement "à plat" (dette technique) |
| Sous-OU | 6 | Users, Admins, Services, Servers, Workstations, Groups |
| Domain Admins | 3 | da1, da2, da3 — mdp `DAPass123!` |
| Admins T1 | 12 | adm_t1_01 à adm_t1_12 — mdp `AdmT1_2024` |
| Comptes service SPN | 3 | svc_sql, svc_backup, svc_web — **mdp faibles, kerberoast** |
| Utilisateurs standards | 650 | user001 à user650 — mdp `User2024!` |
| Groupes | 5+ | GRP_Siege, GRP_Lyon, GRP_Marseille, GRP_Bordeaux, Server_Admins, Admins_T1 |

## Mots de passe faibles (volontaire — reproduction du pentest A1)

| Compte | Mot de passe | Pourquoi faible |
|---|---|---|
| svc_sql | `Summer2024` | Top 100 rockyou, saison + année |
| svc_backup | `Backup2024` | Nom du service + année |
| svc_web | `Welcome123` | Classique top 10 rockyou |

Ces 3 comptes ont un SPN : ils sont kerberoastables et crackables en
moins d'une minute avec hashcat + rockyou.txt.

## Idempotence

Le script est **idempotent** : vous pouvez le relancer autant de fois que
vous voulez, il ne créera pas de doublons. Si un utilisateur existe déjà,
il est ignoré.

C'est utile si :
- Vous avez un échec à mi-parcours (réseau, timeout) → relancez, il reprend.
- Vous voulez ajouter des utilisateurs après coup (changer `-NbStandardUsers`).

## Options

```powershell
# Peuplement avec moins d'users (pour tests rapides)
.\peuplement-ad.ps1 -NbStandardUsers 50

# Dry-run avec trace détaillée
.\peuplement-ad.ps1 -DryRun -Verbose

# Domaine différent (si vous testez sur un autre lab)
.\peuplement-ad.ps1 -Domain "autre.local"
```

## Après exécution — étapes suivantes à faire à la main

Le script **ne fait volontairement PAS** (à faire vous-même pour rester
près des rôles BloodHound/Certipy du pentest) :

1. **Installer ADCS** (Server Manager → Add Roles → AD Certificate Services →
   Enterprise Root CA).
2. **Créer le template vulnérable ESC1** :
   - `certtmpl.msc`
   - Clic droit sur `User` → `Duplicate Template`
   - Nom : `VulnTemplate`
   - Onglet `Subject Name` → cocher `Supply in the request` (= ENROLLEE_SUPPLIES_SUBJECT)
   - Onglet `Security` → Authenticated Users : Enroll + Read
   - Publier le template via `certsrv.msc` → Certificate Templates → New → Certificate Template to Issue
3. **Ouvrir le zone transfer DNS** :
   - `dnsmgmt.msc` → zone `secuvia.local` → Properties → Zone Transfers → `To any server`
4. **Joindre CLIENT01** au domaine.
5. **Snapshot VMware `LAB_BEFORE`** sur toutes les VMs.

## Résumé pour la Visio 2 (validation labs jumeaux)

Pour prouver que vos deux labs sont identiques, chacun montre en partage
d'écran :

```powershell
# Doit afficher 650+ (selon NbStandardUsers)
(Get-ADUser -Filter *).Count

# Doit afficher 3 DA
(Get-ADGroupMember "Domain Admins").Count

# Doit lister svc_sql, svc_backup, svc_web
Get-ADUser -Filter {ServicePrincipalName -like "*"} | Select SamAccountName
```

Si les deux affichent les mêmes chiffres → vos labs sont jumeaux. ✅
