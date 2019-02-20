#!/usr/bin/env bash

service ssh start
service rsyslog start
service nginx start
service php7.0-fpm start
cron

tail -f /dev/null