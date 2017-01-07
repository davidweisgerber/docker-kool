#!/bin/bash

cd /var/www/html/kOOL

if [ ! -f "/data/ko-config.php" ]; then
  mv config/ko-config.php /data/ko-config.php
fi
rm config/ko-config.php
ln -s /data/ko-config.php config/ko-config.php

if [ ! -f "/data/address.rtf" ]; then
  mv config/address.rtf /data/address.rtf
fi
rm config/address.rtf
ln -s /data/address.rtf config/address.rtf

if [ ! -f "/data/leute_formular.inc" ]; then
  mv config/leute_formular.inc /data/leute_formular.inc
fi
rm config/leute_formular.inc
ln -s /data/leute_formular.inc config/leute_formular.inc

if [ ! -d "/data/my_images" ]; then
  mv my_images /data
fi
rm -rf my_images
ln -s /data/my_images my_images

if [ ! -d "/data/templates_c" ]; then
  mv templates_c /data
fi
rm -rf templates_c
ln -s /data/templates_c templates_c

if [ ! -d "/data/webfolders" ]; then
  mv webfolders /data
fi
rm -rf webfolders
ln -s /data/webfolders webfolders

if [ ! -d "/data/.webfolders" ]; then
  mv .webfolders /data
fi
rm -rf .webfolders
ln -s /data/.webfolders .webfolders

if [ ! -d "/data/mysql" ]; then
  rm -rf /var/lib/mysql && mkdir /data/mysql && ln -s /data/mysql /var/lib/mysql && chmod 777 /var/lib/mysql 
  mysql_install_db
  /etc/init.d/mysql start

  source <(grep = /etc/mysql/debian.cnf | sed 's/ *= */=/g')
  mysql -uroot -e "CREATE USER 'debian-sys-maint'@'localhost' IDENTIFIED BY '$password'"
  mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' WITH GRANT OPTION"
  mysql -uroot -e "CREATE DATABASE kOOL"
  mysql -uroot -e "CREATE USER 'kOOL'@'%' IDENTIFIED BY 'kOOL'"
  mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'kOOL'@'%' WITH GRANT OPTION"
  mysql kOOL < /var/www/html/kOOL/install/kOOL_db.sql
  mysql -uroot kOOL -e "INSERT INTO ko_admin (id, leute_id, login, password, admin, leute_admin, leute_admin_filter, leute_admin_spalten, leute_admin_groups, leute_admin_gs, res_admin, rota_admin, event_admin, fileshare_admin, kg_admin, tapes_admin, groups_admin, donations_admin, tracking_admin, modules, last_login, disabled, admingroups, email, mobile) VALUES  (3,0,'root','63a9f0ea7bb98050796b649e85481845','5','4','b:0;','i:0;','',0,'5,5@grp1,5@grp2','5,5@2,5@3,5@5,5@4','4,4@2,4@1','4','4','4','4','4','4,4@3','daten,leute,reservation,kg,groups,tracking,rota,tapes,fileshare,sms,admin,tools,mailing','2015-11-04 11:37:20','','','','')"
  mysql -uroot -e "FLUSH PRIVILEGES"
else
  rm -rf /var/lib/mysql
  ln -s /data/mysql /var/lib/mysql
  chmod -R 777 /var/lib/mysql
fi

chmod -R 777 /data

cd /var/www/html/mrbs

if [ ! -f "/data/config.inc.php" ]; then
  mv config.inc.php /data/config.inc.php
fi
rm config.inc.php
ln -s /data/config.inc.php config.inc.php

