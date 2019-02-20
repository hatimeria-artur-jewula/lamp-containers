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

RUN apt-get -y install wget curl git vim openssh-server htop sudo rsyslog logrotate software-properties-common

RUN apt-get -y install nodejs npm rsync

RUN add-apt-repository ppa:ondrej/php && apt-get update

# Installing PHP packages
RUN apt-get update
RUN apt-get install -y mysql-server mysql-client \
    nginx php7.0-cli php7.0-common php7.0-readline php7.0-bcmath \
    php-apcu php7.0-curl php7.0-fpm php7.0-gd php-imagick php7.0-json php7.0-soap \
    php7.0-intl php-memcached php7.0-mcrypt php7.0-mysql php-mongodb \
    php-redis php7.0-xsl php7.0-mbstring php7.0-zip php7.0-xml php7.0-opcache
RUN apt-get install -y --fix-missing php-xdebug

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.0/cli/php.ini
RUN sed -i "s/\/run\/php\/php7.0-fpm.sock/9000/" /etc/php/7.0/fpm/pool.d/www.conf
RUN echo "www-data ALL=(ALL) NOPASSWD:/usr/sbin/service php7.0-fpm restart" > /etc/sudoers.d/www-data-phpfpm

ADD ./mods/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

#WEIRD HACK TO MAKE MYSQL WORK AND CREATE NO PASSWORD ACCOUNT FOR ADMIN
RUN mkdir /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && service mysql start && mysql -e "CREATE USER 'admin'@'localhost';GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;"
RUN chown -R www-data:www-data /var/www

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

ADD ./run-server.sh /run-server.sh

EXPOSE 22 3306 80 443

CMD bash -x /run-server.sh
