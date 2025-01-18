#!/bin/bash
# Function to log messages
log() {
    echo "[INFO] $1"
}

# Function to create directories if they don't exist
create_directories() {
    log "Ensuring certificate directories exist..."
    mkdir -p "$(dirname "${CERT_PATH}")"  # Ensure the directory for the certificate exists
    mkdir -p "$(dirname "${KEY_PATH}")"   # Ensure the directory for the key exists
}

# Function to generate SSL certificates if they don't exist
generate_ssl_certificates() {
    if [ -f "${CERT_PATH}" ] && [ -f "${KEY_PATH}" ]; then
        log "SSL certificates already exist. Skipping generation."
    else
        log "Generating SSL certificates..."
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -out "${CERT_PATH}" \
            -keyout "${KEY_PATH}" \
            -subj "/C=FI/L=Helsinki/O=Hive/OU=Student/CN=${DOMAIN_NAME}" > /dev/null 2>&1
        log "SSL certificates generated."
    fi
}

# Function to configure Nginx with the domain name and certificate paths
configure_nginx() {
    log "Configuring Nginx..."
    sed -i "s|DOMAIN_NAME|${DOMAIN_NAME}|g" /etc/nginx/nginx.conf
    sed -i "s|CERT_PATH|${CERT_PATH}|g" /etc/nginx/nginx.conf
    sed -i "s|KEY_PATH|${KEY_PATH}|g" /etc/nginx/nginx.conf
    log "Nginx configured with domain and certificate paths."
}

# Function to start Nginx
start_nginx() {
    log "Starting Nginx..."
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
