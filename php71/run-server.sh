#!/usr/bin/env bash

service ssh start
service rsyslog start
service nginx start
service php7.1-fpm start
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && service mysql start
cron

tail -f /dev/null