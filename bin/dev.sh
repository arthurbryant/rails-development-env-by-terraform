#!/usr/bin/env bash
sed -i '$a PS1="[dev \\u@\\h \\W]\\$"' ~/.bash_profile
sudo mv /etc/my.cnf /etc/my.cnf.bak
sudo mv ~/conf/mysql/my.cnf /etc/
sudo service mysqld restart
