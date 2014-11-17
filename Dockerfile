#
# Apache PHP Dockerfile
#
# https://github.com/dockerfile/mongodb
#

# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER Odlanier Mendes <dlanileonardo@gmail.com>

ENV SHELL /bin/bash


# Install packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libapache2-mod-php5
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install pwgen
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php-apc
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-gd
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-mcrypt
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-curl
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php-soap
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nano
RUN DEBIAN_FRONTEND=noninteractive php5enmod curl apcu gd json mcrypt mysql mysqli opcache pdo pdo_mysql readline

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
ADD ports.conf /etc/apache2/ports.conf
ADD php.ini /etc/php5/apache2/php.ini
RUN a2enmod rewrite

# EXPOSE 80
# CMD ["/run.sh"]
