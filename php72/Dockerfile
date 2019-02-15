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
RUN apt-get install -y mysql-server mysql-client \
    nginx php7.2-cli php7.2-common php7.2-readline php7.2-bcmath \
    php-apcu php7.2-curl php7.2-fpm php7.2-gd php-imagick php7.2-json php7.2-soap \
    php7.2-intl php-memcached php7.2-mysql php-mongodb \
    php-redis php7.2-xsl php7.2-mbstring php7.2-zip php7.2-xml php7.2-opcache php-xdebug

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.2/cli/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.2/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.2/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.2/cli/php.ini
RUN sed -i "s/\/run\/php\/php7.2-fpm.sock/9000/" /etc/php/7.2/fpm/pool.d/www.conf
RUN echo "www-data ALL=(ALL) NOPASSWD:/usr/sbin/service php7.2-fpm restart" > /etc/sudoers.d/www-data-phpfpm

ADD ./mods/xdebug.ini /etc/php/7.2/mods-available/xdebug.ini

#WEIRD HACK TO MAKE MYSQL WORK AND CREATE NO PASSWORD ACCOUNT FOR ADMIN
RUN mkdir /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && service mysql start && mysql -e "CREATE USER 'admin'@'localhost';GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;"
RUN chown -R www-data:www-data /var/www

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

ADD ./run-server.sh /run-server.sh

EXPOSE 22 3306 80 443

CMD bash -x /run-server.sh
