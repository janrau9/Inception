#!/bin/bash

# Function to create directories if they don't exist
create_directories() {
    echo "Ensuring certificate directories exist..."
    mkdir -p "$(dirname "${CERT_PATH}")"  # Ensure the directory for the certificate exists
    mkdir -p "$(dirname "${KEY_PATH}")"   # Ensure the directory for the key exists
}

# Function to generate SSL certificates
generate_ssl_certificates() {
    echo "Generating SSL certificates..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -out "${CERT_PATH}" \
        -keyout "${KEY_PATH}" \
        -subj "/C=FI/L=Helsinki/O=Hive/OU=Student/CN=${DOMAIN_NAME}" > /dev/null 2>&1
    echo "SSL certificates generated."
}

# Function to configure Nginx with the domain name and certificate paths
configure_nginx() {
    echo "Configuring Nginx..."
    sed -i "s|DOMAIN_NAME|${DOMAIN_NAME}|g" /etc/nginx/nginx.conf
    sed -i "s|CERT_PATH|${CERT_PATH}|g" /etc/nginx/nginx.conf
    sed -i "s|KEY_PATH|${KEY_PATH}|g" /etc/nginx/nginx.conf
    echo "Nginx configured with domain and certificate paths."
}

# Function to start Nginx
start_nginx() {
    echo "Starting Nginx..."
    nginx -g "daemon off;"
}

# Main script execution
main() {
    create_directories
    generate_ssl_certificates
    configure_nginx
    start_nginx
}

# Execute the main function
main
