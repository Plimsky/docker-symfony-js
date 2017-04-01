FROM ubuntu:latest

MAINTAINER Vincent Nicopolsky <vincent.nicopolsky@gmail.com>

ENV TERM xterm
# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Specify user for correct right
RUN groupmod -g 2000 www-data \
    && usermod -u 2000 -s /bin/bash www-data

# Install Base
RUN apt-get update
RUN apt-get install \
    -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --fix-missing \
    vim nano wget curl htop telnet rsync lynx \
    procps make gcc rsyslog ca-certificates zip daemon \
    acl cpio net-tools apt-utils adduser debconf-utils \
    bzip2 python emacs

# Install Supervisord elements
RUN apt-get install \
    -f -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    supervisor \
    rsyslog

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install \
    -f -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    nodejs \
    build-essential

# Install PHP7 + Apache
RUN apt-get install \
    -f -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    apache2

# Conf Apache
ADD php.ini /etc/php/apache2/php.ini

# Conf Php
RUN service apache2 restart
RUN a2enmod rewrite headers proxy proxy_http proxy_connect
RUN sed -i 's#;date.timezone =#date.timezone = Europe/Paris#g' /etc/php/apache2/php.ini

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
EXPOSE 3000

COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor/
CMD ["/usr/bin/supervisord"]
