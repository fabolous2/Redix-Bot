#!/bin/bash

set -euo pipefail

openssl req -new -text -passout pass:abcd -subj /CN=localhost -out server.req -keyout privkey.pem
openssl rsa -in privkey.pem -passin pass:abcd -out server.key
openssl req -x509 -in server.req -text -key server.key -out server.crt
chmod 600 server.key
chown postgres:postgres server.key

mv server.crt /var/lib/postgresql/server.crt
mv server.key /var/lib/postgresql/server.key