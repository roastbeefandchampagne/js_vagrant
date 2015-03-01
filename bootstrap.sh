#!/usr/bin/env bash
# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015
echo "--RAC: ELASTICSEARCH DEV VAGRANT INSTALL--"
echo "--ELASTICSEARCH + Python 2.7 + NGINX--"

#hostname roastbeefandchampagne.com

apt-get update
apt-get install -y --force-yes git

apt-get install -y --force-yes screen

#mkdir /vagrant/gits
#cd /vagrant/gits

#echo "--RAC: DOWNLOADING GITS FROM GITHUB--"

#get RAC Python Server
#git clone https://github.com/roastbeefandchampagne/python.git
#cd python
#echo "--RAC: CHECKING OUT THE RIGHT BRANCHES--"
#git status
#git stash
#git checkout feature/elasticsearch
#cd feed_module
#chmod +x start.sh
#./start.sh
#echo "RAC: FEED CRON RUNNING..."

#get RAC PHP Frontend
#cd /vagrant/gits
#git clone https://github.com/roastbeefandchampagne/web.git
#cd web
#git status
#git stash
#git checkout cms_online


if [ -d /vagrant ]
then

	#install Engine X
	#echo "--RAC: INSTALLING ENGINE-X AND SETTING FRONTEND--"
	#echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/nginx-stable.list
	#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
	#sudo apt-get install -y --force-yes nginx

	#rm /usr/share/nginx/www/*
	#mv /vagrant/gits* /usr/share/nginx/www/
	#chmod -R 777 /usr/share/nginx/www/*

	#echo "RAC: RESTARTING WEBSERVER"
	#sudo service nginx start

	#echo "RAC: INSTALLING MYSQL SERVER"
	#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
	#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
	#sudo apt-get -y install mysql-server

	echo "--INSTALLING: Node JS--"
	echo "deb http://ftp.us.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list
	curl -sL https://deb.nodesource.com/setup | bash -
	apt-get update
	apt-get install -y --force-yes nodejs
	apt-get install -y build-essential
	apt-get install -y --force-yes npm

	echo "--INSTALLING: Java--"
	apt-get install -y --force-yes openjdk-7-jre

	echo "RAC: INSTALLING Elasticsearch"
	cd /vagrant
	mkdir elasticsearch
	cd elasticsearch
	wget "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb"
	dpkg -i elasticsearch-1.4.4.deb
	#update-rc.d elasticsearch defaults 95 10
	/etc/init.d/elasticsearch start

	#installing marvel
	echo "RAC: INSTALLING ELASTICSEARCH - Marvel"
	cd /usr/share/elasticsearch 
	./bin/plugin -i elasticsearch/marvel/latest
	
	#import dev_python DB
	#echo "RAC: IMPORTING dev DATABASES"
	#mysql -u root -p vagrant -h 127.0.0.1 -P 3306
	#CREATE DATABASE ''dev_python''
	#mysql -u root -p dev_python < /vagrant/dev_python.sql

	echo "RAC: INSTALLING PYTHON 2.7"
	apt-get install python2.7

	echo "RAC: INSTALLING PYTHON PACKAGES"
	apt-get install -y --force-yes libmysqlclient-dev
	apt-get install -y --force-yes python-dev

	mkdir -p /usr/develop/packages
	cd /usr/develop/packages
	wget http://pypi.python.org/packages/source/p/pip/pip-0.7.2.tar.gz
	tar xzf pip-0.7.2.tar.gz
	cd pip-0.7.2
	python setup.py install

	pip install MySQL-python
	pip install feedparser
	pip install elasticsearch

	#install php + dep.
	#echo "RAC: INSTALLING NEWEST VERSION OF PHP 5"
	#apt-get install -y --force-yes php5-fpm

	#clean up
	echo "RAC: CLEANING UP...."
	rm -rf /usr/develop/packages/*.tar.gz
	rm -rf /vagrant/*.deb
	rm -rf /vagrant/elasticsearch

fi

echo "RAC: INSTALL COMPLETE"
echo "RAC: to enter the vagrant use -> vagrant ssh"