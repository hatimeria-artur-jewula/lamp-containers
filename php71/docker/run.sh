#!/bin/bash

# Dockerize configuration files
dockerize \
    -template=/var/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
    -template=/var/docker/php7/cli/php.ini:/etc/php/7.1/cli/php.ini \
    -template=/var/docker/php7/fpm/php.ini:/etc/php/7.1/fpm/php.ini \
    -template=/var/docker/php7/fpm/www.conf:/etc/php/7.1/fpm/pool.d/www.conf \
    -template=/var/docker/php7/xdebug.ini:/etc/php/7.1/mods-available/xdebug.ini \
    -template=/var/docker/mysql/mysql.cnf:/etc/mysql/conf.d/mysql.cnf \
    /bin/true

# Clean logs
echo "" > /var/log/nginx/access.log
echo "" > /var/log/nginx/error.log
echo "" > /var/log/php7.1-fpm.log

echo "Setting up SSH Keys"
mkdir -p /root/.ssh
mkdir -p /var/www/.ssh
cp /root/.ssh.back/* /root/.ssh/
cp /root/.ssh.back/* /var/www/.ssh/
chmod 600 /root/.ssh/id_rsa
chmod 600 /var/www/.ssh/id_rsa
chown www-data:www-data -R /var/www/.ssh/

echo "Setting up Composer"
mkdir -p /root/.composer
mkdir -p /var/www/.composer
cp /root/.composer.back/*.json /root/.composer/
cp /root/.composer.back/*.json /var/www/.composer/
chown www-data:www-data -R /var/www/.composer/

if ! grep -q "/usr/local/node" /root/.bashrc ;
then
    echo "export PATH=\$PATH:/usr/local/node-v8.11.3-linux-x64/bin" > /var/www/.bashrc
    echo "export PATH=\$PATH:/usr/local/node-v8.11.3-linux-x64/bin" >> /root/.bashrc
fi


exec /usr/bin/supervisord
