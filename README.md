## notes

### purge git commit history

to remove previous commits, the following commands were used:

```bash
git checkout --orphan latest_branch
git add -A
git commit -am "initial commit"
git branch -D master
git branch -m master
git push -f origin master
```

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
