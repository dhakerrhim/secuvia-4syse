┌──(kali㉿kali)-[~]
└─$ testssl  --severity MEDIUM 192.168.10.10:636 | tee audit_tls.txt 

#####################################################################
  testssl version 3.2.2 from https://testssl.sh/

  This program is free software. Distribution and modification under
  GPLv2 permitted. USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

  Please file bugs @ https://testssl.sh/bugs/
#####################################################################

  Using OpenSSL 3.5.5 (Jan 27 2026)  [~103 ciphers]
  on kali:/usr/bin/openssl

 Start 2026-04-18 21:10:28        -->> 192.168.10.10:636 (192.168.10.10) <<--

 rDNS (192.168.10.10):   --
 Service detected:       Couldn't determine what's running on port 636, assuming no HTTP service => skipping all HTTP checks

 Testing protocols via sockets except NPN+ALPN 

 SSLv2      not offered (OK)
 SSLv3      not offered (OK)
 TLS 1      offered (deprecated)
 TLS 1.1    offered (deprecated)
 TLS 1.2    offered (OK)
 TLS 1.3    offered (OK): final
 NPN/SPDY   not offered
 ALPN/HTTP2 not offered

 Testing cipher categories 

 NULL ciphers (no encryption)                      not offered (OK)
 Anonymous NULL Ciphers (no authentication)        not offered (OK)
 Export ciphers (w/o ADH+NULL)                     not offered (OK)
 LOW: 64 Bit + DES, RC[2,4], MD5 (w/o export)      not offered (OK)
 Triple DES Ciphers / IDEA                         offered
 Obsoleted CBC ciphers (AES, ARIA etc.)            offered
 Strong encryption (AEAD ciphers) with no FS       offered (OK)
 Forward Secrecy strong encryption (AEAD ciphers)  offered (OK)


 Testing server's cipher preferences 

Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
SSLv2
 - 
SSLv3
 - 
TLSv1 (server order)
 xc014   ECDHE-RSA-AES256-SHA              ECDH 384   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA                 
 xc013   ECDHE-RSA-AES128-SHA              ECDH 253   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA                 
 x35     AES256-SHA                        RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA                       
 x2f     AES128-SHA                        RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA                       
 x0a     DES-CBC3-SHA                      RSA        3DES        168      TLS_RSA_WITH_3DES_EDE_CBC_SHA                      
TLSv1.1 (server order)
 xc014   ECDHE-RSA-AES256-SHA              ECDH 384   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA                 
 xc013   ECDHE-RSA-AES128-SHA              ECDH 253   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA                 
 x35     AES256-SHA                        RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA                       
 x2f     AES128-SHA                        RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA                       
 x0a     DES-CBC3-SHA                      RSA        3DES        168      TLS_RSA_WITH_3DES_EDE_CBC_SHA                      
TLSv1.2 (server order)
 xc030   ECDHE-RSA-AES256-GCM-SHA384       ECDH 384   AESGCM      256      TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384              
 xc02f   ECDHE-RSA-AES128-GCM-SHA256       ECDH 253   AESGCM      128      TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256              
 x9f     DHE-RSA-AES256-GCM-SHA384         DH 2048    AESGCM      256      TLS_DHE_RSA_WITH_AES_256_GCM_SHA384                
 x9e     DHE-RSA-AES128-GCM-SHA256         DH 2048    AESGCM      128      TLS_DHE_RSA_WITH_AES_128_GCM_SHA256                
 xc028   ECDHE-RSA-AES256-SHA384           ECDH 384   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384              
 xc027   ECDHE-RSA-AES128-SHA256           ECDH 253   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256              
 xc014   ECDHE-RSA-AES256-SHA              ECDH 384   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA                 
 xc013   ECDHE-RSA-AES128-SHA              ECDH 253   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA                 
 x9d     AES256-GCM-SHA384                 RSA        AESGCM      256      TLS_RSA_WITH_AES_256_GCM_SHA384                    
 x9c     AES128-GCM-SHA256                 RSA        AESGCM      128      TLS_RSA_WITH_AES_128_GCM_SHA256                    
 x3d     AES256-SHA256                     RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA256                    
 x3c     AES128-SHA256                     RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA256                    
 x35     AES256-SHA                        RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA                       
 x2f     AES128-SHA                        RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA                       
 x0a     DES-CBC3-SHA                      RSA        3DES        168      TLS_RSA_WITH_3DES_EDE_CBC_SHA                      
TLSv1.3 (server order)
 x1302   TLS_AES_256_GCM_SHA384            ECDH 253   AESGCM      256      TLS_AES_256_GCM_SHA384                             
 x1301   TLS_AES_128_GCM_SHA256            ECDH 253   AESGCM      128      TLS_AES_128_GCM_SHA256                             

 Has server cipher order?     yes (OK) -- TLS 1.3 and below


 Testing robust forward secrecy (FS) -- omitting Null Authentication/Encryption, 3DES, RC4 

 FS is offered (OK)           TLS_AES_256_GCM_SHA384 ECDHE-RSA-AES256-GCM-SHA384 ECDHE-RSA-AES256-SHA384 ECDHE-RSA-AES256-SHA DHE-RSA-AES256-GCM-SHA384 TLS_AES_128_GCM_SHA256 ECDHE-RSA-AES128-GCM-SHA256 ECDHE-RSA-AES128-SHA256
                              ECDHE-RSA-AES128-SHA DHE-RSA-AES128-GCM-SHA256 
 Elliptic curves offered:     prime256v1 secp384r1 X25519 
 DH group offered:            ffdhe2048
 TLS 1.2 sig_algs offered:    RSA-PSS-RSAE+SHA256 RSA+SHA256 RSA-PSS-RSAE+SHA384 RSA+SHA384 RSA-PSS-RSAE+SHA512 RSA+SHA512 RSA+SHA1 
 TLS 1.3 sig_algs offered:    RSA-PSS-RSAE+SHA256 RSA-PSS-RSAE+SHA384 RSA-PSS-RSAE+SHA512 

 Testing server defaults (Server Hello) 

 TLS extensions (standard)    "signature algorithms/#13" "extended master secret/#23" "supported versions/#43" "key share/#51" "renegotiation info/#65281"
 Session Ticket RFC 5077 hint no -- no lifetime advertised
 SSL Session ID support       yes
 Session Resumption           Tickets no, ID: yes
 TLS clock skew               0 sec from localtime
 Certificate Compression      none
 Client Authentication        optional
 CA List for Client Auth      empty
 Signature Algorithm          SHA256 with RSA
 Server key size              RSA 2048 bits (exponent is 65537)
 Server key usage             Digital Signature, Key Encipherment
 Server extended key usage    TLS Web Client Authentication, TLS Web Server Authentication
 Serial                       6600000002E9065D399EA2163C000000000002 (OK: length 19)
 Fingerprints                 SHA1 848DE9C6101851C5C95F1324B02CB6F8B252C966
                              SHA256 4BE5415AACB8DFD971D58B22F9BE07D88D4490E7F9FB7AAC3DF1DDD6513CC359
 Common Name (CN)             secuvia.secuvia.local 
 subjectAltName (SAN)         othername: 1.3.6.1.4.1.311.25.1:<unsupported> secuvia.secuvia.local 
 Trust (hostname)             certificate does not match supplied URI
 Chain of trust               NOT ok (chain incomplete)
 EV cert (experimental)       no 
 Certificate Validity (UTC)   364 >= 60 days (2026-04-18 15:58 --> 2027-04-18 15:58)
 ETS/"eTLS", visibility info  not present
 Certificate Revocation List  ldap:///CN=secuvia-SECUVIA-CA,CN=secuvia,CN=CDP,CN=Public%20Key%20Services,CN=Services,CN=Configuration,DC=secuvia,DC=local?certificateRevocationList?base?objectClass=cRLDistributionPoint
 OCSP URI                     --
 OCSP stapling                not offered
 OCSP must staple extension   --
 DNS CAA RR (experimental)    not offered
 Certificate Transparency     N/A
 Certificates provided        1
 Issuer                       secuvia-SECUVIA-CA (secuvia.local)
 Intermediate Bad OCSP (exp.) Ok


 Testing vulnerabilities 

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  (applicable only for HTTP service)
 ROBOT                                     not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK) (not using HTTP anyway)
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK), no SSLv3 support
 TLS_FALLBACK_SCSV (RFC 7507)              Check failed, unexpected result , run testssl -Z --debug=1 and look at /tmp/testssl.IKOCRT/*tls_fallback_scsv.txt
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    VULNERABLE, uses 64 bit block ciphers
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services, see
                                           https://search.censys.io/search?resource=hosts&virtual_hosts=INCLUDE&q=4BE5415AACB8DFD971D58B22F9BE07D88D4490E7F9FB7AAC3DF1DDD6513CC359
 LOGJAM (CVE-2015-4000), experimental      common prime with 2048 bits detected: RFC7919/ffdhe2048 (2048 bits),
                                           but no DH EXPORT ciphers
 BEAST (CVE-2011-3389)                     TLS1: ECDHE-RSA-AES256-SHA ECDHE-RSA-AES128-SHA AES256-SHA AES128-SHA DES-CBC3-SHA 
                                           VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses obsolete cipher block chaining ciphers with TLS, see server prefs.
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)

Could not determine the protocol, only simulating generic clients.

 Running client simulations via sockets 

 Browser                      Protocol  Cipher Suite Name (OpenSSL)       Forward Secrecy
------------------------------------------------------------------------------------------------
 Android 7.0 (native)         TLSv1.2   ECDHE-RSA-AES256-GCM-SHA384       256 bit ECDH (P-256)
 Android 8.1 (native)         TLSv1.2   ECDHE-RSA-AES256-GCM-SHA384       384 bit ECDH (P-384)
 Android 9.0 (native)         TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Android 10.0 (native)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Android 11/12 (native)       TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Android 13/14 (native)       TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Android 15 (native)          TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Chrome 101 (Win 10)          TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Chromium 137 (Win 11)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Firefox 100 (Win 10)         TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Firefox 137 (Win 11)         TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 IE 8 Win 7                   TLSv1.0   ECDHE-RSA-AES256-SHA              384 bit ECDH (P-384)
 IE 11 Win 7                  TLSv1.2   DHE-RSA-AES256-GCM-SHA384         2048 bit DH  (ffdhe2048)
 IE 11 Win 8.1                TLSv1.2   DHE-RSA-AES256-GCM-SHA384         2048 bit DH  (ffdhe2048)
 IE 11 Win Phone 8.1          TLSv1.2   ECDHE-RSA-AES128-SHA256           256 bit ECDH (P-256)
 IE 11 Win 10                 TLSv1.2   ECDHE-RSA-AES256-GCM-SHA384       384 bit ECDH (P-384)
 Edge 15 Win 10               TLSv1.2   ECDHE-RSA-AES256-GCM-SHA384       384 bit ECDH (P-384)
 Edge 101 Win 10 21H2         TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Edge 133 Win 11 23H2         TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Safari 18.4 (iOS 18.4)       TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Safari 15.4 (macOS 12.3.1)   TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Safari 18.4 (macOS 15.4)     TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Java 7u25                    TLSv1.0   ECDHE-RSA-AES128-SHA              256 bit ECDH (P-256)
 Java 8u442 (OpenJDK)         TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Java 11.0.2 (OpenJDK)        TLSv1.3   TLS_AES_256_GCM_SHA384            256 bit ECDH (P-256)
 Java 17.0.3 (OpenJDK)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Java 21.0.6 (OpenJDK)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 go 1.17.8                    TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 LibreSSL 3.3.6 (macOS)       TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 OpenSSL 1.0.2e               TLSv1.2   ECDHE-RSA-AES256-GCM-SHA384       384 bit ECDH (P-384)
 OpenSSL 1.1.1d (Debian)      TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 OpenSSL 3.0.15 (Debian)      TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 OpenSSL 3.5.0 (git)          TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Apple Mail (16.0)            TLSv1.2   ECDHE-RSA-AES256-GCM-SHA384       384 bit ECDH (P-384)
 Thunderbird (91.9)           TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)


 Rating (experimental) 

 Rating specs (not complete)  SSL Labs's 'SSL Server Rating Guide' (version 2009r from 2025-05-16)
 Specification documentation  https://github.com/ssllabs/research/wiki/SSL-Server-Rating-Guide
 Protocol Support (weighted)  0 (0)
 Key Exchange     (weighted)  0 (0)
 Cipher Strength  (weighted)  0 (0)
 Final Score                  0
 Overall Grade                M
 Grade cap reasons            Grade capped to M. Domain name mismatch
                              Grade capped to B. TLS 1.1 offered
                              Grade capped to B. TLS 1.0 offered
                              Grade capped to B. Issues with chain of trust (chain incomplete)

 Done 2026-04-18 21:11:57 [  93s] -->> 192.168.10.10:636 (192.168.10.10) <<--


### Synthèse de l'Audit de Sécurité des Flux (TLS/LDAPS)

Risque : Faible/Moyen. Ces protocoles sont obsolètes et vulnérables à des attaques de type "Man-in-the-Middle" (comme POODLE ou BEAST).

Scoring : Faible (4.0/10).

Recommandation : Désactiver TLS 1.0 et 1.1 dans le registre Windows du serveur SECUVIA pour n'autoriser que TLS 1.2 et 1.3.