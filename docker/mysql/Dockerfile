FROM debian:8.3

ENV TERM xterm
# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Install mysql-server and supervisor
RUN apt-get update
RUN apt-get update --fix-missing
RUN apt-get install -f -y --force-yes pwgen
RUN apt-get install -f -y --force-yes mysql-server
RUN apt-get install -f -y --force-yes cron
RUN apt-get install -f -y --force-yes emacs
RUN apt-get install -f -y --force-yes supervisor
RUN apt-get install -f -y --force-yes rsyslog

# Clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD my.cnf /etc/mysql/my.cnf

# Mysql config
RUN echo mysql-server mysql-server/root_password password root | debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password root | debconf-set-selections

RUN /usr/sbin/mysqld & \
    sleep 10s &&\
    echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql &&\
    echo "CREATE DATABASE web;" | mysql

# Add backup cron
RUN crontab -l | { cat; echo "*/10 * * * * mysqldump -u root -proot web > /var/www/sql_backup/backup.sql"; } | crontab -

EXPOSE 3306

COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor/
CMD ["/usr/bin/supervisord"]
