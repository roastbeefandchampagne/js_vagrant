#!/usr/bin/env bash
# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015

echo "--RAC: DEV VAGRANT Master Branch--"
echo "--Elasticsearch + Marvel + Kibana + Logstash + Python 2.7 + Nginx--"

apt-get update
apt-get install -y --force-yes git

apt-get install -y --force-yes screen
apt-get install -y --force-yes build-essential

if [ -d /vagrant/sys ]
then

	echo "--INSTALLING: Java--"
	apt-get install -y --force-yes openjdk-7-jre

	echo "RAC: INSTALLING Elasticsearch"
	cd /home
	mkdir elasticsearch
	cd elasticsearch
	wget "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.1.deb"
	dpkg -i elasticsearch-*.deb
	update-rc.d elasticsearch defaults 95 10

	#installing marvel
	echo "RAC: INSTALLING ELASTICSEARCH - Marvel"
	cd /usr/share/elasticsearch 
	./bin/plugin -i elasticsearch/marvel/latest

	#installing logstash
	cd /home/elasticsearch
	wget "https://download.elastic.co/logstash/logstash/packages/debian/logstash_1.5.3-1_all.deb"
	dpkg -i logstash*.deb
	cp /vagrant/sys/logstash/run_logstash_config.sh /vagrant/run_logstash_config.sh
	chmod -R 777 /vagrant/run_logstash_config.sh

	cd /vagrant
	./start_all.sh

	#install kibana
	cd /home/elasticsearch
	wget "https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz"
	tar -zxf kibana-*-linux-x64.tar.gz

	#install Nginx
	cd /vagrant
	apt-get install -y --force-yes php5-fpm
	cp /vagrant/sys/php/php.ini /etc/php5/fpm/php.ini
	service php5-fpm restart

	apt-get install -y --force-yes nginx
	cp /vagrant/sys/nginx/default /etc/nginx/sites-available/default
	apt-get install -y --force-yes apache2-utils
	service nginx restart

	echo "RAC: INSTALLING MYSQL SERVER"
	debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
	debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
	apt-get install -y --force-yes mysql-server

	echo "RAC: INSTALLING PYTHON 2.7"
	apt-get install -y --force-yes python2.7

	echo "RAC: INSTALLING PYTHON PACKAGES"
	apt-get install -y --force-yes python-bs4
	apt-get install -y --force-yes libmysqlclient-dev
	apt-get install -y --force-yes python-dev

	mkdir -p /home/develop/packages
	cd /home/develop/packages
	wget http://pypi.python.org/packages/source/p/pip/pip-0.7.2.tar.gz
	tar -zxf pip-0.7.2.tar.gz
	cd pip-0.7.2
	python setup.py install

	pip install beautifulsoup4
	pip install MySQL-python
	pip install feedparser
	pip install elasticsearch
	pip install pygoogle
	pip install requests
	pip install tornado

	#clean up
	echo "RAC: CLEANING UP...."
	rm -rf /home/develop/packages/*.tar.gz
	#rm -rf /vagrant/*.deb
	#rm -rf /vagrant/elasticsearch

fi

echo "RAC: INSTALL COMPLETE"
echo "RAC: to enter the vagrant use -> vagrant ssh"