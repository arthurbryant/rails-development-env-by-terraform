#!/bin/bash

sudo yum -y update
sudo yum -y install git
sudo yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel libffi-devel libxml2 libxslt libxml2-devel libxslt-devel sqlite-devel libtool postgresql-devel libicu-devel
chmod 701 /home/ec2-user

# install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export RBENV_ROOT="/home/ec2-user/.rbenv"' >> ~/.bash_profile
echo 'export PATH=$RBENV_ROOT/bin:$PATH' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

# install ruby
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
CONFIGURE_OPTS="--disable-install-rdoc" rbenv install --verbose 2.3.3;
rbenv global 2.3.3;
rbenv local 2.3.3

# install bundle
gem install bundler

# install unicorn
gem install unicorn; rbenv rehash

# install mysql
sudo yum -y install mysql mysql-server mysql-devel
sudo chkconfig mysqld on
chkconfig | grep mysql
sudo /etc/init.d/mysqld restart

# install sidekiq
gem install sidekiq

gem install dotenv

# log rotate
sudo mv /etc/logrotate.conf /etc/logrotate.conf.bak
sudo mv ~/conf/log/logrotate.conf /etc/
sudo /usr/sbin/logrotate -f /etc/logrotate.conf

# install ag
sudo rpm -ivh http://swiftsignal.com/packages/centos/6/x86_64/the-silver-searcher-0.13.1-1.el6.x86_64.rpm

# add git auto-complete
cd; wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
sleep 3
mv ~/git-completion.bash ~/.git-completion.bash
sed -i '$a source ~/.git-completion.bash' ~/.bash_profile
sudo rpm -ivh ./bash-completion-20060301-1.noarch.rpm
. /etc/bash_completion

# create swap
sudo dd if=/dev/zero of=/swapfile bs=1M count=1500
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sed -i '$a /swapfile swap swap defaults 0 0' /etc/fstab
