
# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER Luis Baroni <luis.baroni@lbenterprise.info>

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

# Ensure UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN dpkg-reconfigure locales

# Install dependencies and pear packages
RUN apt-get update \
  && apt-get upgrade -yq \
  && apt-get -yq install \
      ca-certificates bindfs vim git-core \
      supervisor apache2 libapache2-mod-php5 php5-mysql pwgen php-apc php5-gd \
      php5-mcrypt php5-curl php-soap nano php5-memcache php5-imagick php5-dev \
      openjdk-7-jdk ant \
  && apt-get clean -qq \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/mysql/*

RUN pear channel-discover zend.googlecode.com/svn \
  && pear channel-discover pear.doctrine-project.org \
  && pear channel-discover pear.phing.info \
  && pear channel-discover pear.phpunit.de \
  && pear channel-discover components.ez.no \
  && pear channel-discover pear.pdepend.org \
  && pear channel-discover pear.phpmd.org \
  && pear channel-discover pear.symfony.com \
  && pear channel-discover pear.netpirates.net

RUN pear install -o zend/zend-1.12.7 \
        doctrine/DoctrineORM-2.3.3 \
        phing/phing \
        pear.phpunit.de/PHPUnit-3.7.28 \
        pear.phpunit.de/DbUnit \
        phpunit/PHPUnit_Story \
        phpunit/PHPUnit_Selenium \
        phpunit/phpcpd \
        phpunit/phploc \
        phpunit/PHP_Invoker  \
        pdepend/PHP_Depend-beta  \
        phpmd/PHP_PMD  \
        pear/PHP_CodeSniffer  \
        pear/PhpDocumentor

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
ADD ports.conf /etc/apache2/ports.conf
ADD php.ini /etc/php5/apache2/php.ini

# Enable apache2 and php5 modules
RUN a2enmod rewrite \
  && php5enmod curl apcu gd json mcrypt mysql mysqli opcache \
      pdo pdo_mysql readline imagick memcache dev


ENV SHELL /bin/bash

# EXPOSE 80
# CMD ["/run.sh"]
