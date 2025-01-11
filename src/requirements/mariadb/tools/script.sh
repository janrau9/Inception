#!/bin/sh

# Function to log messages
log() {
    echo "[INFO] $1"
}

# Function to start MariaDB temporarily
start_mariadb_temp() {
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    log "Starting MariaDB temporarily for the WordPress database setup..."
    mysqld &
    log "Waiting for MariaDB to initialize..."
    sleep 2
    until mysqladmin ping --silent; do
        log "MariaDB is not ready yet, retrying..."
        sleep 2
    done
    log "MariaDB is ready."
}

# Function to create the WordPress database and user
setup_database() {
    if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
        log "Database $DB_NAME does not exist. Creating database and user..."
        mysql -u root --execute="
            DROP DATABASE IF EXISTS $DB_NAME;
            CREATE DATABASE $DB_NAME;
            CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
            GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
            ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
            FLUSH PRIVILEGES;
        "
        log "Database $DB_NAME and user $DB_USER created successfully."
    else
        log "Database $DB_NAME already exists. Skipping database creation."
    fi
}

# Function to stop the temporary MariaDB process
shutdown_mariadb_temp() {
    log "Shutting down temporary MariaDB instance..."
    mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown
}

# Function to start MariaDB in regular mode
start_mariadb_regular() {
    log "Starting MariaDB in regular mode..."
    exec mysqld
}

# Main script execution
main() {
    start_mariadb_temp
    setup_database
    shutdown_mariadb_temp
    start_mariadb_regular
}

main
