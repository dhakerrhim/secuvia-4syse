<#
.SYNOPSIS
    Peuplement du lab AD Secuvia - 4SYSE (Adam & Dhaker)

.DESCRIPTION
    Script IDEMPOTENT de peuplement de l'Active Directory Secuvia pour
    garantir que les labs d'Adam et Dhaker sont strictement identiques.

    Contenu créé :
      - OU structure (volontairement "à plat" pour reproduire la dette technique)
      - 3 Domain Admins (da1, da2, da3)
      - 12 admins T1 (adm_t1_01 à adm_t1_12)
      - 3 comptes de service avec SPN et mots de passe faibles (A1 pentest)
      - 650 utilisateurs standards (user001 à user650)
      - Groupes par agence
      - Quelques postes fictifs dans l'OU Computers

    Prérequis :
      - Windows Server 2022 promu contrôleur de domaine
      - Domaine : secuvia.local
      - Exécution en tant qu'administrateur du domaine
      - Module ActiveDirectory (RSAT AD) installé

.NOTES
    Auteur       : Adam & Dhaker
    Cours        : 4SYSE - Audit et sécurisation d'infrastructure
    Version      : 1.0
    À exécuter   : APRÈS la promotion du DC et AVANT l'audit BloodHound
    Commit Git   : /lab/scripts-adam/peuplement-ad.ps1

.EXAMPLE
    .\peuplement-ad.ps1
    Peuple l'AD avec les valeurs par défaut

.EXAMPLE
    .\peuplement-ad.ps1 -Verbose
    Peuple avec trace détaillée

.EXAMPLE
    .\peuplement-ad.ps1 -DryRun
    Simule le peuplement sans rien écrire (test)
#>

[CmdletBinding()]
param(
    [string]$Domain        = "secuvia.local",
    [string]$DomainNetbios = "SECUVIA",
    [int]$NbStandardUsers  = 650,
    [int]$NbAdminsT1       = 12,
    [int]$NbDomainAdmins   = 3,
    [switch]$DryRun
)

# ---------------------------------------------------------------------------
# Bandeau
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Peuplement AD Secuvia - 4SYSE (Adam & Dhaker)" -ForegroundColor Cyan
Write-Host "  Domaine  : $Domain" -ForegroundColor Cyan
Write-Host "  Mode     : $(if ($DryRun) { 'DRY-RUN (simulation)' } else { 'EXÉCUTION RÉELLE' })" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# ---------------------------------------------------------------------------
# Vérifications préalables
# ---------------------------------------------------------------------------
Write-Host "[1/8] Vérifications préalables..." -ForegroundColor Yellow

# Module AD présent ?
if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    Write-Error "Module ActiveDirectory introuvable. Installe RSAT AD d'abord :`n" +
                "Install-WindowsFeature -Name RSAT-AD-PowerShell"
    exit 1
}
Import-Module ActiveDirectory -ErrorAction Stop

# On est bien sur le bon domaine ?
try {
    $currentDomain = (Get-ADDomain).DNSRoot
    if ($currentDomain -ne $Domain) {
        Write-Error "Mauvais domaine : $currentDomain (attendu $Domain)."
        exit 1
    }
} catch {
    Write-Error "Impossible de lire le domaine AD. Le DC est-il promu ?"
    exit 1
}

# On est admin ?
$isAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Error "Relance PowerShell en tant qu'administrateur."
    exit 1
}

Write-Host "  OK — domaine $Domain, admin, module AD présent." -ForegroundColor Green
Write-Host ""

# ---------------------------------------------------------------------------
# Constantes
# ---------------------------------------------------------------------------
$DomainDN = (Get-ADDomain).DistinguishedName
$AgencyList = @("Siege", "Lyon", "Marseille", "Bordeaux")

# Mots de passe VOLONTAIREMENT FAIBLES (reproduction du pentest A1)
$PwdStandard = ConvertTo-SecureString "User2024!"  -AsPlainText -Force
$PwdAdminT1  = ConvertTo-SecureString "AdmT1_2024"  -AsPlainText -Force
$PwdDA       = ConvertTo-SecureString "DAPass123!"  -AsPlainText -Force
# Ces 3 mots de passe sont dans rockyou.txt ou dérivables → kerberoast facile
$PwdSvcSQL    = ConvertTo-SecureString "Summer2024"  -AsPlainText -Force
$PwdSvcBackup = ConvertTo-SecureString "Backup2024"  -AsPlainText -Force
$PwdSvcWeb    = ConvertTo-SecureString "Welcome123"  -AsPlainText -Force

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
function Invoke-Safe {
    param([scriptblock]$Action, [string]$Label)
    if ($DryRun) {
        Write-Host "    [DRY-RUN] $Label" -ForegroundColor DarkGray
        return
    }
    try {
        & $Action
        Write-Verbose "  OK : $Label"
    } catch {
        Write-Warning "  KO : $Label — $($_.Exception.Message)"
    }
}

function Ensure-OU {
    param([string]$Name, [string]$Path)
    $dn = "OU=$Name,$Path"
    if (Get-ADOrganizationalUnit -Filter "Name -eq '$Name'" -SearchBase $Path `
        -SearchScope OneLevel -ErrorAction SilentlyContinue) {
        Write-Verbose "  OU déjà présente : $dn"
        return
    }
    Invoke-Safe -Label "Création OU $dn" -Action {
        New-ADOrganizationalUnit -Name $Name -Path $Path `
            -ProtectedFromAccidentalDeletion $false
    }
}

function Ensure-User {
    param(
        [string]$SamAccountName,
        [string]$DisplayName,
        [securestring]$Password,
        [string]$Path,
        [string[]]$SPNs = @(),
        [switch]$PasswordNeverExpires,
        [switch]$CannotChangePassword
    )
    if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" `
        -ErrorAction SilentlyContinue) {
        Write-Verbose "  User déjà présent : $SamAccountName"
        return
    }
    Invoke-Safe -Label "Création user $SamAccountName" -Action {
        $params = @{
            SamAccountName        = $SamAccountName
            Name                  = $DisplayName
            DisplayName           = $DisplayName
            UserPrincipalName     = "$SamAccountName@$Domain"
            AccountPassword       = $Password
            Enabled               = $true
            Path                  = $Path
            PasswordNeverExpires  = [bool]$PasswordNeverExpires
            CannotChangePassword  = [bool]$CannotChangePassword
        }
        if ($SPNs -and $SPNs.Count -gt 0) {
            $params["ServicePrincipalNames"] = $SPNs
        }
        New-ADUser @params
    }
}

function Ensure-Group {
    param([string]$Name, [string]$Path, [string]$Scope = "Global")
    if (Get-ADGroup -Filter "Name -eq '$Name'" -ErrorAction SilentlyContinue) {
        Write-Verbose "  Groupe déjà présent : $Name"
        return
    }
    Invoke-Safe -Label "Création groupe $Name" -Action {
        New-ADGroup -Name $Name -GroupScope $Scope -Path $Path
    }
}

# ---------------------------------------------------------------------------
# 2. Création des OU (volontairement "plates" pour la dette technique)
# ---------------------------------------------------------------------------
Write-Host "[2/8] Création de la structure OU (volontairement à plat)..." `
    -ForegroundColor Yellow

# Dette technique : une seule OU "Secuvia" qui contient tout le monde,
# mélangeant DA, admins, users et serveurs. C'est ce que l'audit BloodHound
# pointera comme problème majeur (A4 du pentest).
$OuRoot      = "OU=Secuvia,$DomainDN"
$OuUsers     = "OU=Users,OU=Secuvia,$DomainDN"
$OuAdmins    = "OU=Admins,OU=Secuvia,$DomainDN"
$OuServices  = "OU=Services,OU=Secuvia,$DomainDN"
$OuServers   = "OU=Servers,OU=Secuvia,$DomainDN"
$OuWorkstations = "OU=Workstations,OU=Secuvia,$DomainDN"
$OuGroups    = "OU=Groups,OU=Secuvia,$DomainDN"

Ensure-OU -Name "Secuvia"      -Path $DomainDN
Ensure-OU -Name "Users"        -Path $OuRoot
Ensure-OU -Name "Admins"       -Path $OuRoot
Ensure-OU -Name "Services"     -Path $OuRoot
Ensure-OU -Name "Servers"      -Path $OuRoot
Ensure-OU -Name "Workstations" -Path $OuRoot
Ensure-OU -Name "Groups"       -Path $OuRoot

Write-Host ""

# ---------------------------------------------------------------------------
# 3. Domain Admins (3 comptes)
# ---------------------------------------------------------------------------
Write-Host "[3/8] Création des Domain Admins..." -ForegroundColor Yellow

for ($i = 1; $i -le $NbDomainAdmins; $i++) {
    $sam = "da{0}" -f $i
    Ensure-User -SamAccountName $sam -DisplayName "Domain Admin $i" `
        -Password $PwdDA -Path $OuAdmins -PasswordNeverExpires

    if (-not $DryRun) {
        Invoke-Safe -Label "Ajout $sam dans Domain Admins" -Action {
            Add-ADGroupMember -Identity "Domain Admins" -Members $sam `
                -ErrorAction Stop
        }
    }
}

Write-Host ""

# ---------------------------------------------------------------------------
# 4. Admins Tier 1 (12 comptes) — PAS encore dans un groupe dédié
# ---------------------------------------------------------------------------
Write-Host "[4/8] Création des 12 admins T1..." -ForegroundColor Yellow

Ensure-Group -Name "Admins_T1" -Path $OuGroups

for ($i = 1; $i -le $NbAdminsT1; $i++) {
    $sam = "adm_t1_{0:D2}" -f $i
    Ensure-User -SamAccountName $sam -DisplayName "Admin T1 $i" `
        -Password $PwdAdminT1 -Path $OuAdmins

    if (-not $DryRun) {
        Invoke-Safe -Label "Ajout $sam dans Admins_T1" -Action {
            Add-ADGroupMember -Identity "Admins_T1" -Members $sam `
                -ErrorAction Stop
        }
    }
}

Write-Host ""

# ---------------------------------------------------------------------------
# 5. Comptes de service avec SPN (cible kerberoasting A1)
# ---------------------------------------------------------------------------
Write-Host "[5/8] Création des comptes de service avec SPN faibles..." `
    -ForegroundColor Yellow

# svc_sql
Ensure-User -SamAccountName "svc_sql" `
    -DisplayName "Service SQL Server" `
    -Password $PwdSvcSQL -Path $OuServices `
    -SPNs @("MSSQLSvc/sqlsrv.$Domain:1433", "MSSQLSvc/sqlsrv.$Domain") `
    -PasswordNeverExpires -CannotChangePassword

# svc_backup
Ensure-User -SamAccountName "svc_backup" `
    -DisplayName "Service Backup Veeam" `
    -Password $PwdSvcBackup -Path $OuServices `
    -SPNs @("HTTP/backup.$Domain", "HTTP/backup") `
    -PasswordNeverExpires -CannotChangePassword

# svc_web
Ensure-User -SamAccountName "svc_web" `
    -DisplayName "Service Web IIS" `
    -Password $PwdSvcWeb -Path $OuServices `
    -SPNs @("HTTP/web.$Domain", "HTTP/web", "www/web.$Domain") `
    -PasswordNeverExpires -CannotChangePassword

Write-Host ""

# ---------------------------------------------------------------------------
# 6. Utilisateurs standards (650 par défaut)
# ---------------------------------------------------------------------------
Write-Host "[6/8] Création de $NbStandardUsers utilisateurs standards..." `
    -ForegroundColor Yellow
Write-Host "  (cela peut prendre 2-3 minutes, soyez patients)" `
    -ForegroundColor DarkGray

# Répartition par agence pour faire plus réaliste
$progressStep = [math]::Max(1, [math]::Floor($NbStandardUsers / 20))

for ($i = 1; $i -le $NbStandardUsers; $i++) {
    $sam = "user{0:D3}" -f $i
    $agence = $AgencyList[($i - 1) % $AgencyList.Count]
    $displayName = "User $i ($agence)"

    if ((Get-ADUser -Filter "SamAccountName -eq '$sam'" `
         -ErrorAction SilentlyContinue)) {
        continue
    }

    if ($DryRun) {
        if ($i % $progressStep -eq 0) {
            Write-Host "    [DRY-RUN] user $i / $NbStandardUsers" `
                -ForegroundColor DarkGray
        }
        continue
    }

    try {
        New-ADUser -SamAccountName $sam -Name $displayName `
            -DisplayName $displayName `
            -UserPrincipalName "$sam@$Domain" `
            -AccountPassword $PwdStandard -Enabled $true `
            -Path $OuUsers -Department $agence `
            -ErrorAction Stop
    } catch {
        Write-Warning "  KO : user $sam — $($_.Exception.Message)"
    }

    if ($i % $progressStep -eq 0) {
        $pct = [math]::Floor(($i / $NbStandardUsers) * 100)
        Write-Host ("    Progression : {0} / {1} ({2}%)" `
            -f $i, $NbStandardUsers, $pct) -ForegroundColor DarkGray
    }
}

Write-Host ""

# ---------------------------------------------------------------------------
# 7. Groupes par agence (pour enrichir les chemins BloodHound)
# ---------------------------------------------------------------------------
Write-Host "[7/8] Création des groupes par agence..." -ForegroundColor Yellow

foreach ($agence in $AgencyList) {
    Ensure-Group -Name "GRP_$agence" -Path $OuGroups

    if (-not $DryRun) {
        # Ajouter les users de l'agence au groupe (sample : 10 premiers)
        $usersAgence = Get-ADUser -Filter "Department -eq '$agence'" `
            -SearchBase $OuUsers -ResultSetSize 10 -ErrorAction SilentlyContinue
        foreach ($u in $usersAgence) {
            Invoke-Safe -Label "Ajout $($u.SamAccountName) dans GRP_$agence" `
                -Action {
                Add-ADGroupMember -Identity "GRP_$agence" -Members $u `
                    -ErrorAction Stop
            }
        }
    }
}

# Groupe fictif "Server Admins" pour créer un chemin d'attaque intéressant
Ensure-Group -Name "Server_Admins" -Path $OuGroups
if (-not $DryRun) {
    # On met un admin T1 dedans pour créer un chemin vers des serveurs
    Invoke-Safe -Label "Seed Server_Admins avec adm_t1_01" -Action {
        Add-ADGroupMember -Identity "Server_Admins" -Members "adm_t1_01" `
            -ErrorAction Stop
    }
}

Write-Host ""

# ---------------------------------------------------------------------------
# 8. Récapitulatif
# ---------------------------------------------------------------------------
Write-Host "[8/8] Récapitulatif" -ForegroundColor Yellow

if (-not $DryRun) {
    $cntUsers  = (Get-ADUser  -Filter * -SearchBase $OuRoot).Count
    $cntGroups = (Get-ADGroup -Filter * -SearchBase $OuRoot).Count
    $cntOUs    = (Get-ADOrganizationalUnit -Filter * -SearchBase $OuRoot).Count

    Write-Host ""
    Write-Host "  Utilisateurs dans OU=Secuvia : $cntUsers"  -ForegroundColor Green
    Write-Host "  Groupes dans OU=Secuvia      : $cntGroups" -ForegroundColor Green
    Write-Host "  OUs sous OU=Secuvia          : $cntOUs"    -ForegroundColor Green

    Write-Host ""
    Write-Host "  Comptes sensibles créés :" -ForegroundColor Green
    Write-Host "    - da1/da2/da3           (Domain Admins, mdp : DAPass123!)"
    Write-Host "    - adm_t1_01 à adm_t1_12 (Admins T1, mdp   : AdmT1_2024)"
    Write-Host "    - svc_sql               (SPN MSSQLSvc,     mdp : Summer2024)"
    Write-Host "    - svc_backup            (SPN HTTP/backup,  mdp : Backup2024)"
    Write-Host "    - svc_web               (SPN HTTP/web,     mdp : Welcome123)"
    Write-Host "    - user001 à user$($NbStandardUsers.ToString('D3'))  (standards, mdp : User2024!)"
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Peuplement terminé." -ForegroundColor Cyan
Write-Host "" -ForegroundColor Cyan
Write-Host "  PROCHAINES ÉTAPES :" -ForegroundColor Cyan
Write-Host "    1. Installer ADCS Enterprise Root CA (rôle Server Manager)" -ForegroundColor Cyan
Write-Host "    2. Dupliquer le template 'User' en 'VulnTemplate'" -ForegroundColor Cyan
Write-Host "       et activer ENROLLEE_SUPPLIES_SUBJECT (ESC1)" -ForegroundColor Cyan
Write-Host "    3. Ouvrir le zone transfer DNS (BEFORE)" -ForegroundColor Cyan
Write-Host "    4. Prendre un snapshot 'LAB_BEFORE'" -ForegroundColor Cyan
Write-Host "    5. Lancer SharpHound / bloodhound-python" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
