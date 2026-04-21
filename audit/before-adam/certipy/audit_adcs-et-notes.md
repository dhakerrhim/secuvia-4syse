[*] Finding certificate templates
[*] Found 33 certificate templates
[*] Finding certificate authorities
[*] Found 1 certificate authority
[*] Found 11 enabled certificate templates
[*] Finding issuance policies
[*] Found 13 issuance policies
[*] Found 0 OIDs linked to templates
[*] Retrieving CA configuration for 'secuvia-SECUVIA-CA' via RRP
[!] Failed to connect to remote registry. Service should be starting now. Trying again...
[*] Successfully retrieved CA configuration for 'secuvia-SECUVIA-CA'
[*] Checking web enrollment for CA 'secuvia-SECUVIA-CA' @ 'secuvia.secuvia.local'
[!] Error checking web enrollment: [Errno 111] Connection refused
[!] Use -debug to print a stacktrace
[*] Enumeration output:
Certificate Authorities
  0
    CA Name                             : secuvia-SECUVIA-CA
    DNS Name                            : secuvia.secuvia.local
    Certificate Subject                 : CN=secuvia-SECUVIA-CA, DC=secuvia, DC=local
    Certificate Serial Number           : 5B69385031521A83411D6B0AD6775763
    Certificate Validity Start          : 2026-04-18 15:56:52+00:00
    Certificate Validity End            : 2031-04-18 16:06:52+00:00
    Web Enrollment
      HTTP
        Enabled                         : False
      HTTPS
        Enabled                         : False
    User Specified SAN                  : Disabled
    Request Disposition                 : Issue
    Enforce Encryption for Requests     : Enabled
    Active Policy                       : CertificateAuthority_MicrosoftDefault.Policy
    Permissions
      Owner                             : SECUVIA.LOCAL\Administrators
      Access Rights
        ManageCa                        : SECUVIA.LOCAL\Administrators
                                          SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        ManageCertificates              : SECUVIA.LOCAL\Administrators
                                          SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Enroll                          : SECUVIA.LOCAL\Authenticated Users
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Authenticated Users
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Administrators
                                          SECUVIA.LOCAL\Domain Admins
    [!] Vulnerabilities
      ESC7                              : User has dangerous permissions.
Certificate Templates
  0
    Template Name                       : KerberosAuthentication
    Display Name                        : Kerberos Authentication
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDomainDns
                                          SubjectAltRequireDns
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Client Authentication
                                          Server Authentication
                                          Smart Card Logon
                                          KDC Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 2
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:02+00:00
    Template Last Modified              : 2026-04-18T16:07:02+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Enterprise Read-only Domain Controllers
                                          SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
        Write Property AutoEnroll       : SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  1
    Template Name                       : OCSPResponseSigning
    Display Name                        : OCSP Response Signing
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDns
                                          SubjectRequireDnsAsCn
    Enrollment Flag                     : AddOcspNocheck
                                          Norevocationinfoinissuedcerts
    Extended Key Usage                  : OCSP Signing
    Requires Manager Approval           : False
    Requires Key Archival               : False
    RA Application Policies             : msPKI-Asymmetric-Algorithm`PZPWSTR`RSA`msPKI-Hash-Algorithm`PZPWSTR`SHA1`msPKI-Key-Security-Descriptor`PZPWSTR`D:P(A;;FA;;;BA)(A;;FA;;;SY)(A;;GR;;;S-1-5-80-3804348527-3718992918-2141599610-3686422417-2726379419)`msPKI-Key-Usage`DWORD`2`
    Authorized Signatures Required      : 0
    Schema Version                      : 3
    Validity Period                     : 2 weeks
    Renewal Period                      : 2 days
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:02+00:00
    Template Last Modified              : 2026-04-18T16:07:02+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  2
    Template Name                       : RASAndIASServer
    Display Name                        : RAS and IAS Server
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDns
                                          SubjectRequireCommonName
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Client Authentication
                                          Server Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 2
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:02+00:00
    Template Last Modified              : 2026-04-18T16:07:02+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\RAS and IAS Servers
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\RAS and IAS Servers
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  3
    Template Name                       : Workstation
    Display Name                        : Workstation Authentication
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDns
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Client Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 2
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:02+00:00
    Template Last Modified              : 2026-04-18T16:07:02+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Computers
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Computers
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  4
    Template Name                       : DirectoryEmailReplication
    Display Name                        : Directory Email Replication
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDirectoryGuid
                                          SubjectAltRequireDns
    Enrollment Flag                     : IncludeSymmetricAlgorithms
                                          PublishToDs
                                          AutoEnrollment
    Extended Key Usage                  : Directory Service Email Replication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 2
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:02+00:00
    Template Last Modified              : 2026-04-18T16:07:02+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Enterprise Read-only Domain Controllers
                                          SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
        Write Property AutoEnroll       : SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  5
    Template Name                       : DomainControllerAuthentication
    Display Name                        : Domain Controller Authentication
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : Client Authentication
                                          Server Authentication
                                          Smart Card Logon
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 2
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:02+00:00
    Template Last Modified              : 2026-04-20T10:31:17+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Read-only Domain Controllers
                                          SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
        Write Property AutoEnroll       : SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC1                              : Enrollee supplies subject and template allows client authentication.
      ESC4                              : Template is owned by user.
  6
    Template Name                       : KeyRecoveryAgent
    Display Name                        : Key Recovery Agent
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : IncludeSymmetricAlgorithms
                                          PendAllRequests
                                          PublishToKraContainer
                                          AutoEnrollment
    Private Key Flag                    : ExportableKey
    Extended Key Usage                  : Key Recovery Agent
    Requires Manager Approval           : True
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 2
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:02+00:00
    Template Last Modified              : 2026-04-18T16:07:02+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  7
    Template Name                       : CAExchange
    Display Name                        : CA Exchange
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Enrollment Flag                     : IncludeSymmetricAlgorithms
    Extended Key Usage                  : Private Key Archival
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 2
    Validity Period                     : 1 week
    Renewal Period                      : 1 day
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  8
    Template Name                       : CrossCA
    Display Name                        : Cross Certification Authority
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : True
    Any Purpose                         : True
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Enrollment Flag                     : PublishToDs
    Private Key Flag                    : ExportableKey
    Requires Manager Approval           : False
    Requires Key Archival               : False
    RA Application Policies             : Qualified Subordination
    Authorized Signatures Required      : 1
    Schema Version                      : 2
    Validity Period                     : 5 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  9
    Template Name                       : ExchangeUserSignature
    Display Name                        : Exchange Signature Only
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : Secure Email
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  10
    Template Name                       : ExchangeUser
    Display Name                        : Exchange User
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Enrollment Flag                     : IncludeSymmetricAlgorithms
    Private Key Flag                    : ExportableKey
    Extended Key Usage                  : Secure Email
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  11
    Template Name                       : CEPEncryption
    Display Name                        : CEP Encryption
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : True
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : Certificate Request Agent
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  12
    Template Name                       : OfflineRouter
    Display Name                        : Router (Offline request)
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : Client Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  13
    Template Name                       : IPSECIntermediateOffline
    Display Name                        : IPSec (Offline request)
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : IP security IKE intermediate
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  14
    Template Name                       : IPSECIntermediateOnline
    Display Name                        : IPSec
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDns
                                          SubjectRequireDnsAsCn
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : IP security IKE intermediate
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Computers
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Computers
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  15
    Template Name                       : SubCA
    Display Name                        : Subordinate Certification Authority
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : True
    Enrollment Agent                    : True
    Any Purpose                         : True
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Private Key Flag                    : ExportableKey
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 5 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC1                              : Enrollee supplies subject and template allows client authentication.
      ESC2                              : Template can be used for any purpose.
      ESC3                              : Template has Certificate Request Agent EKU set.
      ESC15                             : Enrollee supplies subject and schema version is 1.
      ESC4                              : Template is owned by user.
    [*] Remarks
      ESC15                             : Only applicable if the environment has not been patched. See CVE-2024-49019 or the wiki for more details.
      ESC2 Target Template              : Template can be targeted as part of ESC2 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
      ESC3 Target Template              : Template can be targeted as part of ESC3 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
  16
    Template Name                       : CA
    Display Name                        : Root Certification Authority
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : True
    Any Purpose                         : True
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Private Key Flag                    : ExportableKey
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 5 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  17
    Template Name                       : WebServer
    Display Name                        : Web Server
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : Server Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC15                             : Enrollee supplies subject and schema version is 1.
      ESC4                              : Template is owned by user.
    [*] Remarks
      ESC15                             : Only applicable if the environment has not been patched. See CVE-2024-49019 or the wiki for more details.
  18
    Template Name                       : DomainController
    Display Name                        : Domain Controller
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDirectoryGuid
                                          SubjectAltRequireDns
                                          SubjectRequireDnsAsCn
    Enrollment Flag                     : IncludeSymmetricAlgorithms
                                          PublishToDs
                                          AutoEnrollment
    Extended Key Usage                  : Client Authentication
                                          Server Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Enterprise Read-only Domain Controllers
                                          SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Controllers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Enterprise Domain Controllers
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
    [*] Remarks
      ESC2 Target Template              : Template can be targeted as part of ESC2 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
      ESC3 Target Template              : Template can be targeted as part of ESC3 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
  19
    Template Name                       : Machine
    Display Name                        : Computer
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDns
                                          SubjectRequireDnsAsCn
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Client Authentication
                                          Server Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Computers
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Computers
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Domain Computers
                                          SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
    [*] Remarks
      ESC2 Target Template              : Template can be targeted as part of ESC2 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
      ESC3 Target Template              : Template can be targeted as part of ESC3 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
  20
    Template Name                       : MachineEnrollmentAgent
    Display Name                        : Enrollment Agent (Computer)
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : True
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireDns
                                          SubjectRequireDnsAsCn
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Certificate Request Agent
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  21
    Template Name                       : EnrollmentAgentOffline
    Display Name                        : Exchange Enrollment Agent (Offline request)
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : True
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : Certificate Request Agent
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  22
    Template Name                       : EnrollmentAgent
    Display Name                        : Enrollment Agent
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : True
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Certificate Request Agent
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  23
    Template Name                       : CTLSigning
    Display Name                        : Trust List Signing
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Microsoft Trust List Signing
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  24
    Template Name                       : CodeSigning
    Display Name                        : Code Signing
    Enabled                             : False
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Code Signing
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  25
    Template Name                       : EFSRecovery
    Display Name                        : EFS Recovery Agent
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : IncludeSymmetricAlgorithms
                                          AutoEnrollment
    Private Key Flag                    : ExportableKey
    Extended Key Usage                  : File Recovery
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 5 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  26
    Template Name                       : Administrator
    Display Name                        : Administrator
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectAltRequireEmail
                                          SubjectRequireEmail
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : IncludeSymmetricAlgorithms
                                          PublishToDs
                                          AutoEnrollment
    Private Key Flag                    : ExportableKey
    Extended Key Usage                  : Microsoft Trust List Signing
                                          Encrypting File System
                                          Secure Email
                                          Client Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
    [*] Remarks
      ESC2 Target Template              : Template can be targeted as part of ESC2 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
      ESC3 Target Template              : Template can be targeted as part of ESC3 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
  27
    Template Name                       : EFS
    Display Name                        : Basic EFS
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : IncludeSymmetricAlgorithms
                                          PublishToDs
                                          AutoEnrollment
    Private Key Flag                    : ExportableKey
    Extended Key Usage                  : Encrypting File System
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  28
    Template Name                       : SmartcardLogon
    Display Name                        : Smartcard Logon
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectRequireDirectoryPath
    Extended Key Usage                  : Client Authentication
                                          Smart Card Logon
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  29
    Template Name                       : ClientAuth
    Display Name                        : Authenticated Session
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Client Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  30
    Template Name                       : SmartcardUser
    Display Name                        : Smartcard User
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectAltRequireEmail
                                          SubjectRequireEmail
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : IncludeSymmetricAlgorithms
                                          PublishToDs
    Extended Key Usage                  : Secure Email
                                          Client Authentication
                                          Smart Card Logon
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  31
    Template Name                       : UserSignature
    Display Name                        : User Signature Only
    Enabled                             : False
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectAltRequireEmail
                                          SubjectRequireEmail
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : AutoEnrollment
    Extended Key Usage                  : Secure Email
                                          Client Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
  32
    Template Name                       : User
    Display Name                        : User
    Certificate Authorities             : secuvia-SECUVIA-CA
    Enabled                             : True
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectAltRequireUpn
                                          SubjectAltRequireEmail
                                          SubjectRequireEmail
                                          SubjectRequireDirectoryPath
    Enrollment Flag                     : IncludeSymmetricAlgorithms
                                          PublishToDs
                                          AutoEnrollment
    Private Key Flag                    : ExportableKey
    Extended Key Usage                  : Encrypting File System
                                          Secure Email
                                          Client Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 1 year
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2026-04-18T16:07:01+00:00
    Template Last Modified              : 2026-04-18T16:07:01+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Admins
      Object Control Permissions
        Owner                           : SECUVIA.LOCAL\Enterprise Admins
        Full Control Principals         : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Owner Principals          : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Dacl Principals           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Enterprise Admins
        Write Property Enroll           : SECUVIA.LOCAL\Domain Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Enterprise Admins
    [+] User Enrollable Principals      : SECUVIA.LOCAL\Enterprise Admins
                                          SECUVIA.LOCAL\Domain Users
                                          SECUVIA.LOCAL\Domain Admins
    [+] User ACL Principals             : SECUVIA.LOCAL\Enterprise Admins
    [!] Vulnerabilities
      ESC4                              : Template is owned by user.
    [*] Remarks
      ESC2 Target Template              : Template can be targeted as part of ESC2 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
      ESC3 Target Template              : Template can be targeted as part of ESC3 exploitation. This is not a vulnerability by itself. See the wiki for more details. Template has schema version 1.
                                                                                                                                                                                                         

### Synthèse de l'Audit des Services de Certificats (ADCS)

Risque : Critique. L'ESC4 permet à un utilisateur standard de modifier les paramètres du modèle de certificat pour se donner des droits excessifs, menant souvent à une compromission totale du domaine (Domain Admin).

Scoring : Critique (9.0/10).

Recommandation : Restreindre les permissions d'écriture sur les modèles de certificats. Seuls les "Domain Admins" devraient avoir le droit de modifier ces modèles.
