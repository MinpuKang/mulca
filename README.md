# mulca
This is used to check multiple certificates in one file based on openssl

For example:

There certificats are in one file:
```
[coreuser@HK-CentOS ca]$ cat ca.crt | grep -w "CERTIFICATE"
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
[coreuser@HK-CentOS ca]$
```

## openssl issue

openssl always print out the first certificates:
```
[coreuser@HK-CentOS ca]$ openssl x509 -in ca.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            76:29:aa:20:fa:8a:8e:76:24:a2:19:36:f4:ad:1a:aa
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=US, O=VeriSign, Inc., OU=VeriSign Trust Network, OU=Terms of use at https://www.verisign.com/rpa (c)10, CN=VeriSign Class 3 International Server CA - G3
        Validity
            Not Before: Sep 17 00:00:00 2015 GMT
            Not After : Aug 31 23:59:59 2016 GMT
        Subject: C=CN, ST=Beijing, L=Beijing, O=Beijing Baidu Netcom Science Technology Co., Ltd., OU=service operation department, CN=baidu.com
        Subject Public Key Info:
         ..............
         e1:44:28:42:c5:dd:13:a4:51:a8:bf:fe:30:da:93:36:c5:1e:
         76:e0:c6:cd
[coreuser@HK-CentOS ca]$
```

## mulca is coded to check all certificates in one file based on openssl

The printout of mulca:

```
[coreuser@HK-CentOS ca]$ ./mulca ca.crt
Total Certificate found: 3

########Certificate 1#######
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            76:29:aa:20:fa:8a:8e:76:24:a2:19:36:f4:ad:1a:aa
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=US, O=VeriSign, Inc., OU=VeriSign Trust Network, OU=Terms of use at https://www.verisign.com/rpa (c)10, CN=VeriSign Class 3 International Server CA - G3
        Validity
            Not Before: Sep 17 00:00:00 2015 GMT
            Not After : Aug 31 23:59:59 2016 GMT
        Subject: C=CN, ST=Beijing, L=Beijing, O=Beijing Baidu Netcom Science Technology Co., Ltd., OU=service operation department, CN=baidu.com
        Subject Public Key Info:
            ...............
    Signature Algorithm: sha1WithRSAEncryption
         ...............
         76:e0:c6:cd


########Certificate 2#######
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            64:1b:e8:20:ce:02:08:13:f3:2d:4d:2d:95:d6:7e:67
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=US, O=VeriSign, Inc., OU=VeriSign Trust Network, OU=(c) 2006 VeriSign, Inc. - For authorized use only, CN=VeriSign Class 3 Public Primary Certification Authority - G5
        Validity
            Not Before: Feb  8 00:00:00 2010 GMT
            Not After : Feb  7 23:59:59 2020 GMT
        Subject: C=US, O=VeriSign, Inc., OU=VeriSign Trust Network, OU=Terms of use at https://www.verisign.com/rpa (c)10, CN=VeriSign Class 3 International Server CA - G3
        Subject Public Key Info:
            ...............
    Signature Algorithm: sha1WithRSAEncryption
         ...............
         78:43:99:a8


########Certificate 3#######
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            18:da:d1:9e:26:7d:e8:bb:4a:21:58:cd:cc:6b:3b:4a
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=US, O=VeriSign, Inc., OU=VeriSign Trust Network, OU=(c) 2006 VeriSign, Inc. - For authorized use only, CN=VeriSign Class 3 Public Primary Certification Authority - G5
        Validity
            Not Before: Nov  8 00:00:00 2006 GMT
            Not After : Jul 16 23:59:59 2036 GMT
        Subject: C=US, O=VeriSign, Inc., OU=VeriSign Trust Network, OU=(c) 2006 VeriSign, Inc. - For authorized use only, CN=VeriSign Class 3 Public Primary Certification Authority - G5
        Subject Public Key Info:
            ...............
    Signature Algorithm: sha1WithRSAEncryption
         ...............
         a8:ed:63:6a


[coreuser@HK-CentOS ca]$
```

## openssl new version

According the designer of openssl, upcoming release 1.1.1 of openssl will fix this issue with new function STORE.

[Multi-CAs in one file cannot be listed out #5962](https://github.com/openssl/openssl/issues/5962#issuecomment-382290344)




