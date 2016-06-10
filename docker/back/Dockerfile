FROM debian:8.3

MAINTAINER Vincent Nicopolsky <vincent.nicopolsky@gmail.com>

ENV TERM xterm
# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Specify user for correct right
RUN groupmod -g 2000 www-data \
    && usermod -u 2000 -s /bin/bash www-data

# Install Base
RUN apt-get update
RUN apt-get install -y --force-yes --fix-missing vim nano wget curl htop telnet rsync lynx \
                                                 procps make gcc rsyslog ca-certificates zip daemon \
                                                 acl cpio net-tools apt-utils adduser debconf-utils \
                                                 bzip2 python emacs

# Install Supervisord elements
RUN apt-get install -f -y --force-yes supervisor
RUN apt-get install -f -y --force-yes rsyslog

# Install Php
RUN apt-get install -f -y --force-yes php5-common php5-cli php5-curl php5-gd php5-intl php5-mcrypt php5-mysql php5-readline php5-dev libapache2-mod-php5 libssl-dev libpcre3-dev libpcre3 libssl-doc
RUN apt-get install -f -y --force-yes apache2 php5-xdebug phpunit mysql-client

# Conf Apache
ADD php.ini /etc/php5/apache2/php.ini

# Conf Php
RUN sed -i 's#;date.timezone =#date.timezone = Europe/Paris#g' /etc/php5/apache2/php.ini
RUN sed -i 's#;date.timezone =#date.timezone = Europe/Paris#g' /etc/php5/cli/php.ini
RUN a2enmod php5 rewrite headers
RUN php5dismod xdebug

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Conf Apache
ADD default.conf /etc/apache2/sites-available/000-default.conf

# Conf alias profile
ADD .bashrc /root/.bashrc

# Define working directory
WORKDIR /var/www

# Expose Ports
EXPOSE 80
EXPOSE 8000

COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor/
CMD ["/usr/bin/supervisord"]
