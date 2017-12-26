#!/usr/bin/env bash
sed -i '$a PS1="[pro \\u@\\h \\W]\\$"' ~/.bash_profile

# awslogs
sudo yum install -y awslogs
sudo mv /etc/awslogs/awscli.conf /etc/awslogs/awscli.conf.bak
sudo mv ~/conf/awslogs/awscli.conf /etc/awslogs/awscli.conf
sudo mv /etc/awslogs/awslogs.conf /etc/awslogs/awslogs.conf.bak
sudo mv ~/conf/awslogs/awslogs.conf /etc/awslogs/awslogs.conf
sudo service awslogs start
sudo chkconfig awslogs on
