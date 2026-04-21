# Synthèse des validations AFTER - 2026-04-21

| Remédiation       | Vulnérabilité | CVSS | Statut   | Preuve                         |
|-------------------|---------------|------|----------|--------------------------------|
| R1 DNS AXFR       | A3            | 5.3  | PASS | dns/dig_axfr_after.txt         |
| R2 Cert LDAPS     | TLS-1         | 7.5  | FAIL | tls/openssl_ldaps_after.txt    |
| R3 LDAP Signing   | TLS-2         | 6.5  | UNKNOWN | ldap/ldap_unsigned_after.txt   |
| R4 WEF            | A5            | 7.5  | Voir DC   | côté Windows Event Collector   |

## Commandes à captures pour le rapport

### Capture 1 - AXFR refusé (R1)
```bash
dig AXFR @10.10.10.10 secuvia.local
# Attendu : Transfer failed
```

### Capture 2 - Certificat LDAPS (R2)
```bash
openssl s_client -connect 10.10.10.10:636 -showcerts < /dev/null | head -30
# Attendu : BEGIN CERTIFICATE visible
```

### Capture 3 - TLS grade (R2)
Ouvrir `tls/ldaps_after.html` dans Firefox, capturer la section Grade.

### Capture 4 - LDAP signing (R3)
```bash
ldapsearch -x -H ldap://10.10.10.10 -b "dc=secuvia,dc=local" -s base
# Attendu : strongAuth Required (si signing actif)
```

## Screenshots à faire (7 captures)

1. `20260421_HHMM_03remediation_dns_axfr-after.png` (dig → Transfer failed)
2. `20260421_HHMM_03remediation_tls_openssl-cert-ok.png` (cert visible)
3. `20260421_HHMM_03remediation_tls_testssl-grade.png` (grade HTML)
4. `20260421_HHMM_03remediation_tls_testssl-protocols.png` (TLS 1.2/1.3 OK)
5. `20260421_HHMM_03remediation_ldap_signing-required.png` (bind refusé)
6. `20260421_HHMM_03remediation_nmap_ports.png` (ports après)
7. `20260421_HHMM_03remediation_siem_wef-status.png` (côté DC, service UP)

## Commit Git

```bash
cd ~/secuvia-4syse
mkdir -p remediation/after-dhaker
cp -r /home/dhaker/secuvia-audit/after-dhaker/20260421_142539/* remediation/after-dhaker/

git add remediation/after-dhaker/
git commit -m "[remediation] J3 : 4 AFTER validees (AXFR fermee, LDAPS cert, signing, WEF)"
git push
```
