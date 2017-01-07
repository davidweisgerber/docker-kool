#!/bin/bash

at_term() { 
  echo "Caught SIGTERM signal!" 
  /etc/init.d/apache2 stop
  /etc/init.d/mysql stop
  
  exit 0
}

trap at_term TERM
  
rm -rf /var/run/mysqld/*
/var/lib/kOOL/setup.sh

/etc/init.d/mysql start
rm -rf /var/run/apache2/apache2.pid
/etc/init.d/apache2 start

/usr/sbin/cron

tail -f /var/log/apache2/access.log -f /var/log/apache2/error.log  &

while true; do
    sleep 1
done
