#!/usr/bin/env bash

# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015

echo "--RAC: VAGRANT INSTALL--"
echo "--Node JS + Meteorite + METEOR APP + ANGULAR JS + Atmosphere--"

#install Node JS
echo "--INSTALLING: Node JS--"
curl -sL https://deb.nodesource.com/setup | sudo bash -
apt-get install -y --force-yes nodejs
sudo apt-get install -y --force-yes npm

apt-get install -y --force-yes screen

#install Meteorite JS
echo "--INSTALLING: Meteorite JS--"
npm install -g meteorite

#install Meteor JS
echo "--INSTALLING: METEOR JS--"
curl https://install.meteor.com/ | sh

mkdir /usr/running
cd /usr/running
mkdir meteor
cd meteor
meteor create myapp
cd myapp
screen -dmS meteor meteor

#install Atmosphere JS
echo "--INSTALLING: Atmosphere--"
meteor add mrt:moment

#install Angular JS
echo "--INSTALLING: Angular JS--"
meteor add urigo:angular

#install python dep.
#apt-get install python2.7


#install PhP + MySQL
#apt-get install -y --force-yes mysql-server php5-mysql

#ifconfig eth0 | grep inet | awk '{ print $2 }'

#install php + dep.
#apt-get install -y --force-yes php5-fpm

#python packages
#pip install feedparser

echo "--INSTALL COMPLETE--"