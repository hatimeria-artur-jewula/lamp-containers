FROM ubuntu:18.04

MAINTAINER Artur Jewula <zefiryn@jewula.net>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install locales && locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

ENV LANGUAGE en_US
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install wget curl git vim openssh-server htop sudo rsyslog logrotate software-properties-common nodejs npm rsync

RUN add-apt-repository ppa:ondrej/php && apt-get update
RUN apt-get -y install \
    wget curl git vim openssh-server htop sudo rsyslog logrotate software-properties-common \
    nodejs npm rsync \
    mysql-client \
    nginx php7.1-cli php7.1-common php7.1-readline php7.1-bcmath \
    php-apcu php7.1-curl php7.1-fpm php7.1-gd php-imagick php7.1-json php7.1-soap \
    php7.1-intl php-memcached php7.1-mcrypt php7.1-mysql php-mongodb \
    php-redis php7.1-xsl php7.1-mbstring php7.1-zip php7.1-xml php7.1-opcache
RUN apt-get update && apt-get install -y --fix-missing php-xdebug

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.1/cli/php.ini \
&& sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.1/fpm/php.ini \
&& sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.1/fpm/php.ini \
&& sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.1/fpm/php.ini \
&& sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.1/cli/php.ini \
&& sed -i "s/\/run\/php\/php7.1-fpm.sock/9000/" /etc/php/7.1/fpm/pool.d/www.conf \
&& echo "www-data ALL=(ALL) NOPASSWD:/usr/sbin/service php7.1-fpm restart" > /etc/sudoers.d/www-data-phpfpm

ADD ./mods/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini

#ADD IONCUBE
ADD ./ioncube/ioncube_loader_lin_7.1.so /usr/lib/php/20160303/
ADD ./mods/ioncube.ini /etc/php/7.1/mods-available/ioncube.ini
RUN ln -s /etc/php/7.1/mods-available/ioncube.ini /etc/php/7.1/fpm/conf.d/00-ioncube.ini
RUN ln -s /etc/php/7.1/mods-available/ioncube.ini /etc/php/7.1/cli/conf.d/00-ioncube.ini


#WEIRD HACK TO MAKE MYSQL WORK AND CREATE NO PASSWORD ACCOUNT FOR ADMIN
RUN chown -R www-data:www-data /var/www

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

ADD ./run-server.sh /run-server.sh

EXPOSE 22 80 443

CMD bash -x /run-server.sh
