#!/bin/bash
if [ ! -f /secure/ssl/mail.crt ]; then
    mkdir -p /secure/ssl && cd /secure/ssl
    openssl genrsa -out mail.key 2048
    openssl req -new -key mail.key -out mail.csr -subj "/C=BE/ST=Limburg/L=Genk/O=Nascom/CN=nascom.be"
    openssl x509 -req -days 3650 -in mail.csr -signkey mail.key -out mail.crt
fi
