FROM debian:latest

RUN apt-get update && apt-get upgrade && apt-get install -y mariadb-server

RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

# initialize MariaDB system database and tables
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

EXPOSE 3306

COPY ./tools/script.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/script.sh

CMD ["./usr/local/bin/script.sh"]