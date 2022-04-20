FROM ubuntu:20.04

MAINTAINER Artur Jewula <artur.jewula@hatimeria.pl>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

ENV LANGUAGE en_US
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install wget curl git vim openssh-server htop sudo rsyslog logrotate software-properties-common \
  rsync ghostscript aspell
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN chmod +x nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install nodejs
RUN npm update -g npm
RUN npm install yarn -g

RUN add-apt-repository ppa:ondrej/php && apt-get update

# Installing PHP packages
RUN apt-get install -y mysql-client \
    nginx php8.1-cli php8.1-common php8.1-readline php8.1-bcmath \
    php-apcu php8.1-curl php8.1-fpm php8.1-gd php-imagick php8.1-soap \
    php8.1-intl php-memcached php8.1-mysql php-mongodb \
    php-redis php8.1-xsl php8.1-mbstring php8.1-zip php8.1-xml php8.1-opcache php-xdebug \
    libsodium-dev


RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/8.1/cli/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/8.1/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/8.1/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/8.1/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/8.1/cli/php.ini
RUN sed -i "s/\/run\/php\/php8.1-fpm.sock/9000/" /etc/php/8.1/fpm/pool.d/www.conf
RUN echo "www-data ALL=(ALL) NOPASSWD:/usr/sbin/service php8.1-fpm restart" > /etc/sudoers.d/www-data-phpfpm

RUN mkdir -p /run/php
ADD ./mods/xdebug-3.ini /etc/php/8.1/mods-available/xdebug.ini

#ADD IONCUBE
#ADD ./ioncube/ioncube_loader_lin_7.4.so /usr/lib/php/20190902/
#ADD ./mods/ioncube.ini /etc/php/7.4/mods-available/ioncube.ini
#RUN ln -s /etc/php/7.4/mods-available/ioncube.ini /etc/php/7.4/fpm/conf.d/00-ioncube.ini
#RUN ln -s /etc/php/7.4/mods-available/ioncube.ini /etc/php/7.4/cli/conf.d/00-ioncube.ini

#ADD SOURCE GUARD
ADD ./sourceguard/ixed.8.1.lin /usr/lib/php/20210902/
ADD ./mods/sourceguard.ini /etc/php/8.1/mods-available/sourceguard.ini
RUN ln -s /etc/php/8.1/mods-available/sourceguard.ini /etc/php/8.1/fpm/conf.d/00-sourceguard.ini
RUN ln -s /etc/php/8.1/mods-available/sourceguard.ini /etc/php/8.1/cli/conf.d/00-sourceguard.ini

RUN chown -R www-data:www-data /var/www

ADD https://getcomposer.org/download/2.3.5/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

ADD ./run-server.sh /run-server.sh

EXPOSE 22 80 443

CMD bash -x /run-server.sh
