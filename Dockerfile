FROM ubuntu:trusty
MAINTAINER Luis Baroni <luis.baroni@lbenterprise.info>

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -yq install curl
RUN apt-get -yq install apache2
RUN apt-get -yq install libapache2-mod-php5
RUN apt-get -yq install php5-mysql
RUN apt-get -yq install php5-gd
RUN apt-get -yq install php5-curl
RUN apt-get -yq install php-pear
RUN apt-get -yq install php5-memcache
RUN apt-get -yq install php5-imagick
RUN apt-get -yq install php5-mcrypt
RUN apt-get -yq install php5-dev
RUN apt-get -yq install php-apc
RUN apt-get -yq install openjdk-7-jdk
RUN apt-get -yq install ant

# Install Pear packages
# RUN pear channel-discover pear.dafitidev.com.br
RUN pear channel-discover zend.googlecode.com/svn
RUN pear channel-discover pear.doctrine-project.org
RUN pear channel-discover pear.phing.info
RUN pear channel-discover pear.phpunit.de
RUN pear channel-discover components.ez.no
RUN pear channel-discover pear.pdepend.org
RUN pear channel-discover pear.phpmd.org
RUN pear channel-discover pear.symfony.com
RUN pear channel-discover pear.netpirates.net

# RUN pear install -o DPEAR/Monolog
# RUN pear install -o DPEAR/DPEAR
RUN pear install -o zend/zend-1.12.7
RUN pear install -o doctrine/DoctrineORM-2.3.3
RUN pear install -o phing/phing
RUN pear install -o pear.phpunit.de/PHPUnit-3.7.28
RUN pear install -o pear.phpunit.de/DbUnit
RUN pear install -o phpunit/PHPUnit_Story
RUN pear install -o phpunit/PHPUnit_Selenium
RUN pear install -o phpunit/phpcpd
RUN pear install -o phpunit/phploc
RUN pear install -o phpunit/PHP_Invoker 
RUN pear install -o pdepend/PHP_Depend-beta 
RUN pear install -o phpmd/PHP_PMD 
RUN pear install -o pear/PHP_CodeSniffer 
RUN pear install -o pear/PhpDocumentor

RUN rm -rf /var/lib/apt/lists/*
#RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable apache mods.
#RUN a2enmod php5
#RUN a2enmod rewrite

# Add image configuration and scripts
# ADD run.sh /run.sh
# RUN chmod 755 /run.sh

# Configure /logs directory
#VOLUME /logs
#ENV APACHE_LOG_DIR /logs

# Configure /app folder with sample app
#VOLUME /app
#RUN rm -fr /var/www/html && ln -s /app /var/www/html
#RUN chown www-data:www-data /app -R

# Configure php.ini
#ADD php.ini /etc/php5/apache2/php.ini
#ADD php.ini /etc/php5/cli/php.ini

# Configure sites available confs
#ADD sites-available /sites-available
#WORKDIR /sites-available
#RUN for FILE in *; do cp ${FILE} /etc/apache2/sites-available/${FILE} && a2ensite ${FILE}; done;

# EXPOSE 80
# WORKDIR /app
# CMD ["/run.sh"]



# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
ADD ports.conf /etc/apache2/ports.conf
ADD php.ini /etc/php5/apache2/php.ini
RUN a2enmod rewrite
