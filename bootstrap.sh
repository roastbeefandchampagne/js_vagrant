
# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015

apt-get update
apt-get install -y --force-yes git



mkdir /usr/rac_packages
cd /usr/rac_packages
mkdir gits
cd gits

#get RAC Gits
git clone https://github.com/roastbeefandchampagne/python.git
git clone https://github.com/roastbeefandchampagne/web.git

if [ -d /usr/rac_packages/gits ]
then
	apt-get update

	#install Engine X
	echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/nginx-stable.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
	sudo apt-get update
	sudo apt-get install nginx

	rm /usr/share/nginx/www/*
	mv /usr/rac_packages/gits/* /usr/share/nginx/www/

	sudo service nginx start

	ps auxuf

	#install python dep.
	#apt-get install python2.7


	#install PhP + MySQL
	#apt-get install -y --force-yes mysql-server php5-mysql

	ifconfig eth0 | grep inet | awk '{ print $2 }'

	#install php + dep.
	#apt-get install -y --force-yes php5-fpm

fi