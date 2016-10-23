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

# Install PHP7 + Apache
RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list
RUN wget -O- https://www.dotdeb.org/dotdeb.gpg | apt-key add -
RUN apt-get update
RUN apt-get install -f -y --force-yes apache2 php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json php7.0-gd php7.0-mcrypt php7.0-msgpack php7.0-memcached php7.0-intl php7.0-sqlite3 php7.0-gmp php7.0-geoip php7.0-mbstring php7.0-xml php7.0-zip
RUN apt-get install -f -y --force-yes php7.0-xdebug phpunit mysql-client

# Conf Apache
ADD php.ini /etc/php7.0/apache2/php.ini

# Conf Php
RUN a2enmod php7.0 rewrite headers proxy proxy_http proxy_connect
RUN sed -i 's#;date.timezone =#date.timezone = Europe/Paris#g' /etc/php/7.0/apache2/php.ini
RUN sed -i 's#;date.timezone =#date.timezone = Europe/Paris#g' /etc/php/7.0/cli/php.ini
RUN phpdismod xdebug

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv /composer.phar /usr/local/bin/composer

# Install Symfony
RUN mkdir -p /usr/local/bin
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony

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
