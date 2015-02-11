#!/usr/bin/env bash

# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015

echo "--RAC: VAGRANT INSTALL--"
echo "--ANGULAR JS + METEOR APP--"

apt-get update
#apt-get install -y --force-yes git

apt-get install -y --force-yes screen


#install Meteor JS
curl https://install.meteor.com/ | sh

mkdir /usr/running
cd /usr/running
mkdir meteor
cd meteor
meteor create myapp
cd myapp
screen -dmS meteor meteor


#install Angular JS



#install python dep.
#apt-get install python2.7


#install PhP + MySQL
#apt-get install -y --force-yes mysql-server php5-mysql

#ifconfig eth0 | grep inet | awk '{ print $2 }'

#install php + dep.
#apt-get install -y --force-yes php5-fpm

#python packages
#pip install feedparser