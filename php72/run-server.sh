#!/usr/bin/env bash

service ssh start
service rsyslog start
service nginx start
service php7.2-fpm start
service mysql stop
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && service mysql restart
cron

tail -f /dev/null