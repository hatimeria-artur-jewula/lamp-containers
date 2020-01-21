#!/usr/bin/env bash

service ssh start
service rsyslog start
service nginx start
service php7.2-fpm start
cron

tail -f /dev/null