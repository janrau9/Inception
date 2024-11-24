FROM alpine:latest

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld && \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY mariadb-init.sql /docker-entrypoint-initdb.d/

CMD ["mysqld"]
