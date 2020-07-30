FROM ubuntu:18.04

MAINTAINER Artur Jewula <zefiryn@jewula.net>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

ENV LANGUAGE en_US
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install wget curl git vim openssh-server htop sudo rsyslog logrotate software-properties-common \
  nodejs npm rsync
RUN npm install -g yarn

RUN add-apt-repository ppa:ondrej/php && apt-get update

# Installing PHP packages
RUN apt-get install -y mysql-client \
    nginx php7.3-cli php7.3-common php7.3-readline php7.3-bcmath \
    php-apcu php7.3-curl php7.3-fpm php7.3-gd php-imagick php7.3-json php7.3-soap \
    php7.3-intl php-memcached php7.3-mysql php-mongodb \
    php-redis php7.3-xsl php7.3-mbstring php7.3-zip php7.3-xml php7.3-opcache php-xdebug \
    libsodium-dev

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.3/cli/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.3/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.3/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.3/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.3/cli/php.ini
RUN sed -i "s/\/run\/php\/php7.3-fpm.sock/9000/" /etc/php/7.3/fpm/pool.d/www.conf
RUN echo "www-data ALL=(ALL) NOPASSWD:/usr/sbin/service php7.3-fpm restart" > /etc/sudoers.d/www-data-phpfpm

RUN mkdir -p /run/php
ADD ./mods/xdebug.ini /etc/php/7.3/mods-available/xdebug.ini

#ADD IONCUBE
ADD ./ioncube/ioncube_loader_lin_7.3.so /usr/lib/php/20180731/
ADD ./mods/ioncube.ini /etc/php/7.3/mods-available/ioncube.ini
RUN ln -s /etc/php/7.3/mods-available/ioncube.ini /etc/php/7.3/fpm/conf.d/00-ioncube.ini
RUN ln -s /etc/php/7.3/mods-available/ioncube.ini /etc/php/7.3/cli/conf.d/00-ioncube.ini

RUN chown -R www-data:www-data /var/www

ADD https://getcomposer.org/download/1.10.9/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

ADD ./run-server.sh /run-server.sh

EXPOSE 22 80 443

CMD bash -x /run-server.sh
