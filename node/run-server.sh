#!/usr/bin/env bash

service ssh start
service rsyslog start
service nginx start
cron

tail -f /dev/null