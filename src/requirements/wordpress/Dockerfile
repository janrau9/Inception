FROM debian:latest

RUN apt-get update && apt-get upgrade && apt-get install -y \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-phar \
    php81-mbstring \
    php81-curl \
    php81-openssl \
    curl

EXPOSE 9000
WORKDIR /var/www/html

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/.
COPY ./tools/script.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]

