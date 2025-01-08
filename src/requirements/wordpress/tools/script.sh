#!/bin/bash

# Function to check if MariaDB is ready
wait_for_mariadb() {
    echo "Waiting for MariaDB to be ready..."
    until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" ; do
        echo "MariaDB is not ready, retrying in 3 seconds..."
        sleep 3
    done
    echo "MariaDB is ready!"
}

# Function to install WP-CLI
install_wp_cli() {
    echo "Downloading WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Verify WP-CLI installation
    if [ ! -f "/usr/local/bin/wp" ]; then
        echo "WP-CLI installation failed. Exiting..."
        exit 1
    fi
    echo "WP-CLI installed successfully."
}

# Function to install WordPress
install_wordpress() {
    echo "WordPress is not installed. Installing WordPress..."
    wp core download --allow-root
    wp core config --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --allow-root
    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
    echo "WordPress installed successfully."
}

# Function to set permissions for WordPress files
set_permissions() {
    echo "Setting proper file permissions..."
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
}

# Function to start PHP-FPM
start_php_fpm() {
    echo "Starting PHP-FPM..."
    exec php-fpm81 -F
}

# Main script execution
main () {
    wait_for_mariadb

    if [ ! -f "/var/www/html/wp-config.php" ]; then
        install_wp_cli
        install_wordpress
    else
        echo "WordPress is already installed. Skipping installation."
    fi

    set_permissions
    start_php_fpm
}

# Execute the main function
main