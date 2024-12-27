FROM debian:latest

RUN apt-get update && apt-get install -y nginx openssl

EXPOSE 443

# Copy custom NGINX configuration
COPY nginx.conf /etc/nginx/nginx.conf

COPY script.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/script.sh

CMD ["./usr/local/bin/script.sh"]
