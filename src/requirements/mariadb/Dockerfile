FROM debian:bookworm

RUN apt-get update && apt-get upgrade && apt-get install -y mariadb-client mariadb-server

# initialize MariaDB system database and tables
#RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod -R 755 /var/lib/mysql
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

EXPOSE 3306

COPY ./tools/script.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/script.sh
ENTRYPOINT ["./usr/local/bin/script.sh"]