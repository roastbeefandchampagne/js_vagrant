#!/usr/bin/env bash
# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015
echo "--RAC: VAGRANT INSTALL--"
echo "--NGINX + MYSQL + PYTHON 2.7 + GIT + RAC SYSTEM--"

apt-get update
apt-get install -y --force-yes git

apt-get install -y --force-yes screen

#python packages
pip install feedparser

mkdir /usr/rac_packages
cd /usr/rac_packages
mkdir gits
cd gits

echo "--RAC: DOWNLOADING GITS FROM GITHUB--"

#get RAC Python Server
git clone https://github.com/roastbeefandchampagne/python.git
cd python
echo "--RAC: CHECKING OUT THE RIGHT BRANCHES--"
git status
git stash
git checkout online_server
cd feed_module
chmod +x start.sh
./start.sh
echo "RAC: FEED CRON RUNNING..."

#get RAC PHP Frontend
cd /usr/rac_packages/gits
git clone https://github.com/roastbeefandchampagne/web.git
cd web
git status
git stash
git checkout cms_online
screen -list


exit


if [ -d /usr/rac_packages/gits ]
then
	apt-get update

	#install Engine X
	echo "--RAC: INSTALLING ENGINE-X AND SETTING FRONTEND--"
	echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/nginx-stable.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
	sudo apt-get install -y --force-yes nginx

	rm /usr/share/nginx/www/*
	mv /usr/rac_packages/gits/* /usr/share/nginx/www/
	chmod -R 777 /usr/share/nginx/www/*

	echo "RAC: RESTARTING WEBSERVER"
	sudo service nginx start


	if [ -d /vagrant/sys/packs/netqmail ]
	then
		# install qmail from tar
		cp -R /vagrant/packages/netqmail*.tar.gz /usr/local/src
		cd /usr/local/src
		tar xvzf netqmail*.tar.gz 
		cd netqmail*
		groupadd nofiles
		useradd -g nofiles -d /var/qmail/alias alias
		useradd -g nofiles -d /var/qmail qmaild
		useradd -g nofiles -d /var/qmail qmaill
		useradd -g nofiles -d /var/qmail qmailp
		groupadd qmail
		useradd -g qmail -d /var/qmail qmailq
		useradd -g qmail -d /var/qmail qmailr
		useradd -g qmail -d /var/qmail qmails

		#hostname rac #set hostname

		make setup check
		./config

		chown -R log:log /etc/servers/qmail/log
		#mkdir /var/qmail
		mv /usr/lib/sendmail /usr/lib/sendmail.old
		mv /usr/sbin/sendmail /usr/sbin/sendmail.old
		ln -s /var/qmail/bin/sendmail /usr/lib/sendmail
		ln -s /var/qmail/bin/sendmail /usr/sbin/sendmail
		ln -s /etc/servers/qmail /service

		mv /usr/local/src/netqmail* /usr/local
	fi

	#install python dep.
	#apt-get install python2.7


	#install PhP + MySQL
	#apt-get install -y --force-yes mysql-server php5-mysql

	#ifconfig eth0 | grep inet | awk '{ print $2 }'

	#install php + dep.
	#apt-get install -y --force-yes php5-fpm

fi