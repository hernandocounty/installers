#!/bin/bash

rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm


yum install httpd httpd-devel mysql mysql-server mysql-devel php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml -y

firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=3306/tcp

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload


systemctl start httpd.service
systemctl enable httpd.service
systemctl start mysqld.service
systemctl enable mysqld.service

mysql_secure_installation

yum update -y

mkdir /var/www/html/mailgun


cd /var/www/html/mailgun
curl -sS https://getcomposer.org/installer | php
scp composer.phar /root/composer.phar
mv composer.phar /usr/local/bin/composer


composer global require "fxp/composer-asset-plugin:1.0.0"
composer create-project --prefer-dist yiisoft/yii2-app-advanced yii-application

php /var/www/html/mailgun/yii-application/init
