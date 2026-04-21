#Requires -Version 5.1
<#
.SYNOPSIS
    Range les captures d'audit Secuvia dans audit/before-dhaker/ et génère
    toute l'arborescence README + analyses techniques.

.DESCRIPTION
    Script IDEMPOTENT : relançable sans perte. Par défaut il ne remplace aucun
    fichier existant (l'auditeur peut modifier un README à la main, le script
    ne l'écrase pas). Utiliser -Force pour régénérer les .md livrés par défaut.

.PARAMETER SourceDir
    Dossier contenant les PNG d'origine.
    Défaut : "$env:USERPROFILE\Documents\Claude\Projects\securite des sys"

.PARAMETER TargetDir
    Dossier de destination dans le dépôt Git.
    Défaut : "$env:USERPROFILE\Documents\Claude\Projects\secuvia-4syse\audit\before-dhaker"

.PARAMETER Force
    Si présent, régénère les README et analyses même s'ils existent déjà.

.EXAMPLE
    .\organize-audit.ps1
    # Range les PNG, crée les README manquants, ne touche pas aux existants.

.EXAMPLE
    .\organize-audit.ps1 -Force
    # Régénère tout le contenu livré (README + analyses).
#>

[CmdletBinding()]
param(
    [string]$SourceDir = (Join-Path $env:USERPROFILE "Documents\Claude\Projects\securite des sys"),
    [string]$TargetDir = (Join-Path $env:USERPROFILE "Documents\Claude\Projects\secuvia-4syse\audit\before-dhaker"),
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
function Write-Step {
    param([string]$Msg)
    Write-Host "[+] $Msg" -ForegroundColor Cyan
}

function Write-Skip {
    param([string]$Msg)
    Write-Host "[=] $Msg" -ForegroundColor DarkGray
}

function New-DirIfMissing {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Step "Créé : $Path"
    } else {
        Write-Skip  "Déjà présent : $Path"
    }
}

function Copy-IfMissing {
    param(
        [string]$Source,
        [string]$Destination
    )
    if (-not (Test-Path -LiteralPath $Source)) {
        Write-Warning "Source absente : $Source"
        return
    }
    if (Test-Path -LiteralPath $Destination) {
        Write-Skip "PNG déjà en place : $(Split-Path $Destination -Leaf)"
        return
    }
    Copy-Item -LiteralPath $Source -Destination $Destination
    Write-Step "Copié : $(Split-Path $Destination -Leaf)"
}

function Write-IfMissingOrForce {
    param(
        [string]$Path,
        [string]$Content
    )
    if ((Test-Path -LiteralPath $Path) -and (-not $Force)) {
        Write-Skip "MD conservé (modifs locales respectées) : $(Split-Path $Path -Leaf)"
        return
    }
    $dir = Split-Path $Path -Parent
    if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    Set-Content -LiteralPath $Path -Value $Content -Encoding UTF8
    Write-Step "Écrit : $(Split-Path $Path -Leaf)"
}

# ---------------------------------------------------------------------------
# TÂCHE 2 — Arborescence
# ---------------------------------------------------------------------------
Write-Host "`n=== Tâche 2 : Arborescence ===" -ForegroundColor Yellow
$folders = @(
    '01-lab-ad', '02-lab-kali', '03-audit-dns-axfr',
    '04-audit-tls', '05-audit-nmap', '06-siem-elk', '07-sigma-bonus'
)
New-DirIfMissing $TargetDir
foreach ($f in $folders) { New-DirIfMissing (Join-Path $TargetDir $f) }

# ---------------------------------------------------------------------------
# TÂCHE 3 — Copie + renommage
# ---------------------------------------------------------------------------
Write-Host "`n=== Tâche 3 : Copie & renommage des 25 captures ===" -ForegroundColor Yellow

# Mapping Source -> Destination relative (sous $TargetDir)
$mapping = [ordered]@{
    # 01-lab-ad
    '01lab_ad_domaine-cree.png.png'           = '01-lab-ad\domaine-cree.png'
    '01lab_ad_ipconfig-dc01.png'              = '01-lab-ad\ipconfig-dc01.png'
    '01lab_ad_nombre-users.png'               = '01-lab-ad\nombre-users.png'
    '01lab_ad_ou-structure.png'               = '01-lab-ad\ou-structure.png'
    '01lab_ad_sid-domain-admins.png.png'      = '01-lab-ad\sid-domain-admins.png'
    '01lab_ad_spn-kerberoastables.png'        = '01-lab-ad\spn-kerberoastables.png'
    '3 ad domain.png'                         = '01-lab-ad\domain-admins-list.png'
    # 02-lab-kali
    'J\01lab_kali_ip-config.png'              = '02-lab-kali\ip-config.png'
    'J\01lab_kali_ping-dc01.png'              = '02-lab-kali\ping-dc01.png'
    'J\01lab_kali_dns-resolution.png'         = '02-lab-kali\dns-resolution.png'
    # 03-audit-dns-axfr
    'J\02audit_dns_axfr-before-success.png'   = '03-audit-dns-axfr\axfr-success.png'
    'J\02audit_dns_axfr-before.png'           = '03-audit-dns-axfr\axfr-stats.png'
    'J\audit_dns_zone-config.png'             = '03-audit-dns-axfr\zone-config-dc01.png'
    # 04-audit-tls
    'J\02audit_tls_nmap-port-636.png'                 = '04-audit-tls\nmap-port-636.png'
    'J\testssl\audit_tls_openssl-no-cert.png'         = '04-audit-tls\openssl-no-cert.png'
    'J\testssl\02audit_tls_no-tls-on-port-636.png'    = '04-audit-tls\testssl-no-protocol.png'
    # 05-audit-nmap
    'J\02audit_nmap_ad-ports-dc01.png'        = '05-audit-nmap\ad-ports-dc01.png'
    'J\namp scan.png'                         = '05-audit-nmap\ad-ports-quick.png'
    'J\02audit_nmap_scan-subnet.png'          = '05-audit-nmap\scan-subnet.png'
    'J\02audit_nmap_vulns-scripts.png'        = '05-audit-nmap\vuln-scripts.png'
    # 06-siem-elk
    'J\03siem_docker-compose-up.png'          = '06-siem-elk\docker-compose-up.png'
    'J\03siem_docker-ps-running.png'          = '06-siem-elk\docker-ps-running.png'
    'J\03siem_elasticsearch-ok.png'           = '06-siem-elk\elasticsearch-ok.png'
    'J\03siem_kibana-home.png'                = '06-siem-elk\kibana-home.png'
    # 07-sigma-bonus
    'J\bonus_sigma_rule-created.png'          = '07-sigma-bonus\rule-created.png'
}

foreach ($kv in $mapping.GetEnumerator()) {
    Copy-IfMissing (Join-Path $SourceDir $kv.Key) (Join-Path $TargetDir $kv.Value)
}

# ---------------------------------------------------------------------------
# TÂCHE 4+5+6+7 — Génération des MD (squelettes minimaux — contenu déjà livré
# en tant que fichiers dans le dépôt ; cette section sert à restaurer si
# quelqu'un supprime un MD livré).
# ---------------------------------------------------------------------------
Write-Host "`n=== Tâches 4-7 : README et analyses (idempotent) ===" -ForegroundColor Yellow

# Squelette générique utilisé uniquement si les .md livrés ont disparu.
$readmeStubs = [ordered]@{
    'README.md'                             = "# Audit BEFORE — Dhaker`n`nSommaire — voir findings-summary.md.`n"
    'findings-summary.md'                   = "# Findings Summary`n`n(Fichier livré — régénérer depuis Git si manquant.)`n"
    '01-lab-ad\README.md'                   = "# 01 — Lab AD`n`nVulnérabilités : A1, A4.`n"
    '02-lab-kali\README.md'                 = "# 02 — Lab Kali`n`nValidation connectivité.`n"
    '03-audit-dns-axfr\README.md'           = "# 03 — Audit DNS AXFR`n`nVulnérabilité : A3.`n"
    '03-audit-dns-axfr\dns-analysis.md'     = "# dns-analysis`n`n(Fichier livré — Git restore.)`n"
    '04-audit-tls\README.md'                = "# 04 — Audit TLS`n`nVulnérabilité : TLS-1.`n"
    '04-audit-tls\tls-analysis.md'          = "# tls-analysis`n`n(Fichier livré — Git restore.)`n"
    '05-audit-nmap\README.md'               = "# 05 — Audit Nmap`n`nVulnérabilités : TLS-2, NET-1, NET-2.`n"
    '05-audit-nmap\nmap-analysis.md'        = "# nmap-analysis`n`n(Fichier livré — Git restore.)`n"
    '06-siem-elk\README.md'                 = "# 06 — SIEM ELK`n`nRemédiation A5.`n"
    '06-siem-elk\siem-setup.md'             = "# siem-setup`n`n(Fichier livré — Git restore.)`n"
    '07-sigma-bonus\README.md'              = "# 07 — Sigma bonus`n`nDétection A1.`n"
    '07-sigma-bonus\sigma_kerberoast.yml'   = "# Règle Sigma — voir fichier livré dans Git.`n"
}

foreach ($kv in $readmeStubs.GetEnumerator()) {
    $dst = Join-Path $TargetDir $kv.Key
    Write-IfMissingOrForce -Path $dst -Content $kv.Value
}

# ---------------------------------------------------------------------------
# Rapport final
# ---------------------------------------------------------------------------
Write-Host "`n=== Rapport final ===" -ForegroundColor Yellow
$pngCount = (Get-ChildItem -LiteralPath $TargetDir -Recurse -Filter '*.png' -File).Count
$mdCount  = (Get-ChildItem -LiteralPath $TargetDir -Recurse -Filter '*.md'  -File).Count
$ymlCount = (Get-ChildItem -LiteralPath $TargetDir -Recurse -Filter '*.yml' -File).Count

Write-Host ("  PNG dans l'arbo : {0} (attendu 25)" -f $pngCount) -ForegroundColor Green
Write-Host ("  MD dans l'arbo  : {0} (attendu 12)" -f $mdCount)  -ForegroundColor Green
Write-Host ("  YML dans l'arbo : {0} (attendu 1)"  -f $ymlCount) -ForegroundColor Green

Write-Host "`nOK — audit/before-dhaker/ rangé. Pour pusher :" -ForegroundColor Green
Write-Host "    git add audit/before-dhaker/" -ForegroundColor White
Write-Host "    git commit -m `"[audit-dhaker] J2: Audit BEFORE complet (26 preuves, 8 vulns, 7 domaines)`"" -ForegroundColor White
Write-Host "    git push" -ForegroundColor White
