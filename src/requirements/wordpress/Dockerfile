FROM debian:bookworm

RUN apt-get update && apt-get upgrade && apt-get install -y \
    mariadb-client \
    php8.2 \
    php8.2-fpm \
    php8.2-mysqli \
    php8.2-phar \
    php8.2-mbstring \
    php8.2-curl \
    curl 

EXPOSE 9000
WORKDIR /var/www/html
RUN chown -R 755 /var/www/html

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/.
COPY ./tools/script.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]

