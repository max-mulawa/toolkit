---
id: wrj29b9thpoqqzfd8tra50p
title: Work
desc: ''
updated: 1676450655565
created: 1676450645227
---

```bash
# version
openssl version 
openssl version -a

# list commands
openssl help

# create private RSA key in PKCS #8 format
openssl genpkey -out fd.key \
-algorithm RSA \
-pkeyopt rsa_keygen_bits:2048 \
-aes-128-cbc \
-pass pass:abc123

# view private key content
openssl pkey -in fd.key -text -noout

# export public key from private and pass passphrase from the file 
openssl pkey -in fd.key -pubout -out fd-public.key -passin file:pesist-pass.txt

# create Certificate Signing Request (CSR)
openssl req -new -key fd.key -out fd.csr -passin file:pesist-pass.txt

# or from config


# fd.cnf
# [req]
# prompt = no
# distinguished_name = dn
# x509_extensions = ext
# input_password = abc123

# [dn]
# CN = max-mulawa.com
# emailAddress = max.mulawa@gmail.com
# O = mulawa ltd
# L = Warsaw
# C = PL

# [ext]
# subjectAltName = DNS:www.max-mulawa.com,DNS:max-mulawa.com


# view Certificate Signing Request (CSR) metadata
openssl req -text -in fd.csr -noout

# create self-signed certificate from CSR
openssl x509 -req -days 365 -in fd.csr -signkey fd.key -out fd.crt -passin file:pesist-pass.txt -extfile fd.ext

# fd.ext
# subjectAltName = DNS:www.max-mulawa.com, DNS:max-mulawa.com
# https://security.stackexchange.com/questions/150078/missing-x509-extensions-with-an-openssl-generated-certificate

# or the shortcut without CSR
openssl req -new -x509 -days 365 -key fd.key -out fd.crt -subj "/C=PL/L=Warsaw/O=max-mulawa.com Ltd/CN=www.max-mulawa.com"

# cert in PEM format metadata
openssl x509 -text -in gsrsaovsslca2018.crt -noout -inform pem
```