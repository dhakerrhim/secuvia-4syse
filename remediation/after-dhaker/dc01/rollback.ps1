#Requires -Version 5.1
#Requires -RunAsAdministrator

# Script de rollback - gÃ©nÃ©rÃ© automatiquement
# GÃ©nÃ©rÃ© le : 2026-04-21 14:22:09

Write-Host 'Rollback des remediations Dhaker...' -ForegroundColor Yellow

# R1 - Restaurer la config DNS initiale
Set-DnsServerPrimaryZone -Name 'secuvia.local' -SecureSecondaries TransferAnyServer

# R2 - Supprimer le certificat auto-signe
Get-ChildItem Cert:\LocalMachine\My |
    Where-Object { $_.Thumbprint -eq '18BA3B92D8BBA0D5BDFE134CFF6DB4BD6595F9EB' } |
    Remove-Item -Force

# R3 - Restaurer LDAP signing initial
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters' -Name 'LDAPServerIntegrity' -Value 1 -Type DWord

# R4 - Desactiver WEF (note : peut affecter d'autres services Windows)
# Commande manuelle recommandee : wecutil ds (voir subscriptions) puis Stop-Service Wecsvc

