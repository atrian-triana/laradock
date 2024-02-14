#!/bin/bash

if [ ! -f /etc/nginx/ssl/default.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/default.key" 2048
    openssl req -new -key "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.csr" -subj "/CN=default/O=default/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/default.csr" -signkey "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.crt"
    chmod 644 /etc/nginx/ssl/default.key
fi

if [ ! -f /etc/nginx/ssl/nuwwetest.org.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/nuwwetest.org.key" 2048
    openssl req -new -key "/etc/nginx/ssl/nuwwetest.org.key" -out "/etc/nginx/ssl/nuwwetest.org.csr" -subj "/CN=nuwwetest.org/O=nuwwetest.org/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/nuwwetest.org.csr" -signkey "/etc/nginx/ssl/nuwwetest.org.key" -out "/etc/nginx/ssl/nuwwetest.org.crt"
    chmod 644 /etc/nginx/ssl/nuwwetest.org.key
fi

# Start crond in background
crond -l 2 -b

# Start nginx in foreground
nginx
