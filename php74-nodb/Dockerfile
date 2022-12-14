FROM ubuntu:20.04

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
    nginx php7.4-cli php7.4-common php7.4-readline php7.4-bcmath \
    php7.4-apcu php7.4-curl php7.4-fpm php7.4-gd php7.4-imagick php7.4-json php7.4-soap \
    php7.4-intl php7.4-memcached php7.4-mysql php7.4-mongodb php7.4-dom \
    php7.4-redis php7.4-xsl php7.4-mbstring php7.4-zip php7.4-xml php7.4-opcache php7.4-xdebug \
    libsodium-dev

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.4/cli/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.4/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.4/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.4/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/7.4/cli/php.ini
RUN sed -i "s/\/run\/php\/php7.4-fpm.sock/9000/" /etc/php/7.4/fpm/pool.d/www.conf
RUN echo "www-data ALL=(ALL) NOPASSWD:/usr/sbin/service php7.4-fpm restart" > /etc/sudoers.d/www-data-phpfpm

RUN mkdir -p /run/php
ADD ./mods/xdebug-3.ini /etc/php/7.4/mods-available/xdebug.ini

#ADD IONCUBE
ADD ./ioncube/ioncube_loader_lin_7.4.so /usr/lib/php/20190902/
ADD ./mods/ioncube.ini /etc/php/7.4/mods-available/ioncube.ini
RUN ln -s /etc/php/7.4/mods-available/ioncube.ini /etc/php/7.4/fpm/conf.d/00-ioncube.ini
RUN ln -s /etc/php/7.4/mods-available/ioncube.ini /etc/php/7.4/cli/conf.d/00-ioncube.ini

RUN chown -R www-data:www-data /var/www

COPY --from=composer:1.10.26 /usr/bin/composer /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer2
RUN chmod 755 /usr/local/bin/composer2

ADD ./run-server.sh /run-server.sh

EXPOSE 22 80 443

CMD bash -x /run-server.sh
