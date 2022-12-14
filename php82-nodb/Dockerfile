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
    nginx php8.2-cli php8.2-common php8.2-readline php8.2-bcmath \
    php8.2-apcu php8.2-curl php8.2-fpm php8.2-gd php8.2-imagick php8.2-soap \
    php8.2-intl php8.2-memcached php8.2-mysql php8.2-mongodb \
    php8.2-redis php8.2-xsl php8.2-mbstring php8.2-zip php8.2-xml php8.2-opcache php8.2-xdebug \
    libsodium-dev


RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/8.1/cli/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/8.1/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/8.1/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/8.1/fpm/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 3000/" /etc/php/8.1/cli/php.ini
RUN sed -i "s/\/run\/php\/php8.2-fpm.sock/9000/" /etc/php/8.1/fpm/pool.d/www.conf
RUN echo "www-data ALL=(ALL) NOPASSWD:/usr/sbin/service php8.2-fpm restart" > /etc/sudoers.d/www-data-phpfpm

RUN mkdir -p /run/php
ADD ./mods/xdebug-3.ini /etc/php/8.2/mods-available/xdebug.ini

#ADD IONCUBE
#ADD ./ioncube/ioncube_loader_lin_8.1.so /usr/lib/php/20210902/
#ADD ./mods/ioncube.ini /etc/php/8.1/mods-available/ioncube.ini
#RUN ln -s /etc/php/8.1/mods-available/ioncube.ini /etc/php/8.1/fpm/conf.d/00-ioncube.ini
#RUN ln -s /etc/php/8.1/mods-available/ioncube.ini /etc/php/8.1/cli/conf.d/00-ioncube.ini

#ADD SOURCE GUARD
#ADD ./sourceguard/ixed.8.1.lin /usr/lib/php/20210902/
#ADD ./mods/sourceguard.ini /etc/php/8.1/mods-available/sourceguard.ini
#RUN ln -s /etc/php/8.1/mods-available/sourceguard.ini /etc/php/8.1/fpm/conf.d/00-sourceguard.ini
#RUN ln -s /etc/php/8.1/mods-available/sourceguard.ini /etc/php/8.1/cli/conf.d/00-sourceguard.ini

RUN chown -R www-data:www-data /var/www

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN chmod 755 /usr/bin/composer

ADD ./run-server.sh /run-server.sh

EXPOSE 22 80 443

CMD bash -x /run-server.sh
