#!/bin/bash

# this will install the lampstack on centOS6 with a secure mysql install and
# open up the firewall for port 443 and 80

sudo sh -c "yum install httpd httpd-devel mysql mysql-server mysql-devel php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml -y; service mysqld start && mysql_secure_installation && service mysqld restart && service httpd start && chkconfig httpd on && chkconfig mysqld on && iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT && /etc/init.d/iptables save"

iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT && /etc/init.d/iptables save
