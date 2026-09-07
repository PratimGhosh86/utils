## notes

### purge git commit history

to remove previous commits, the following commands were used:

```bash
git checkout --orphan latest_branch
git add -A
git commit -am "initial commit"
git branch -D main
git branch -m main
git push -f origin main
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

The final two commands remove the old commits from the local `.git` directory.

## generating ssh key

```bash
#!bin/bash

openssl req \
    -newkey rsa:2048 \
    -x509 \
    -nodes \
    -keyout server.key \
    -new \
    -out server.crt \
    -config ./openssl-custom.cnf \
    -sha256 \
    -days 3650
```

## generating keystore/truststore

### generate an RSA keypair with keytool

```bash
keytool -genkeypair \
    -alias server \
    -keyalg RSA \
    -keysize 2048 \
    -validity 3650 \
    -keystore server.keystore.jks \
    -storetype JKS \
    -storepass changeit \
    -keypass changeit \
    -dname "CN=localhost"
```

Export the generated certificate and import it into a truststore:

```bash
keytool -exportcert \
    -rfc \
    -alias server \
    -file server.crt \
    -keystore server.keystore.jks \
    -storepass changeit

keytool -importcert \
    -alias server \
    -file server.crt \
    -keystore server.truststore.jks \
    -storetype JKS \
    -storepass changeit \
    -noprompt
```

### import OpenSSL PEM files

Convert the OpenSSL private key and certificate to PKCS#12, then import them
into a Java keystore:

```bash
openssl pkcs12 -export \
    -in server.crt \
    -inkey server.key \
    -name server \
    -out server.p12 \
    -passout pass:changeit

keytool -importkeystore \
    -srckeystore server.p12 \
    -srcstoretype PKCS12 \
    -srcstorepass changeit \
    -destkeystore server.keystore.jks \
    -deststoretype JKS \
    -deststorepass changeit \
    -destkeypass changeit \
    -alias server
```

Import the OpenSSL certificate into a Java truststore:

```bash
keytool -importcert \
    -alias server \
    -file server.crt \
    -keystore server.truststore.jks \
    -storetype JKS \
    -storepass changeit \
    -noprompt
```
