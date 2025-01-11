FROM debian:bookworm

RUN apt-get update && apt-get upgrade && apt-get install -y nginx openssl

EXPOSE 443

RUN mkdir -p /var/www/html && chown -R 755 /var/www/html
# Copy custom NGINX configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/script.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["./usr/local/bin/script.sh"]
