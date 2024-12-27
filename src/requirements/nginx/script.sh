#!/bin/bash

# Create directories for certificates if not exist

# Generate a self-signed SSL certificate
echo "Generating SSL certificates..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out "${CERT_PATH}" \
    -keyout "${KEY_PATH}" \
    -subj "/C=FI/L=Helsinki/O=Hive/OU=Student/CN=${DOMAIN_NAME}" > /dev/null 2>&1

sed -i "s|DOMAIN_NAME|${DOMAIN_NAME}|g" etc/nginx/nginx.conf
sed -i "s|CERT_PATH|${CERT_PATH}|g" etc/nginx/nginx.conf
sed -i "s|KEY_PATH|${KEY_PATH}|g" etc/nginx/nginx.conf

nginx -g "daemon off;"
 