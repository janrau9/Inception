FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql wget && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    rm latest.tar.gz

CMD ["php-fpm8.1", "-F"]
