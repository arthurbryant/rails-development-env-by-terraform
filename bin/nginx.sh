#!/bin/sh

# install nginx
sudo yum -y install nginx
sudo mv ~/conf/nginx/local.conf /etc/nginx/conf.d/
sudo sed -i -e '/listen.*default_server/ s/^/#/g' /etc/nginx/nginx.conf
sudo /etc/init.d/nginx configtest
sudo /etc/init.d/nginx restart
sudo chkconfig nginx on
