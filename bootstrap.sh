#!/usr/bin/env bash
# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015

echo "--RAC: ELASTICSEARCH - Selenium DEV VAGRANT INSTALL--"
echo "--Elasticsearch + Marvel + Kibana + Logstash/forwarder + Python 2.7 + Selenium + Nginx--"

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

	#installing shield
	#echo "RAC: INSTALLING ELASTICSEARCH - Shield"
	#cd /usr/share/elasticsearch 
	#bin/plugin -i elasticsearch/license/latest
	#bin/plugin -i elasticsearch/shield/latest

	#bin/elasticsearch
	#bin/shield/esusers useradd vagrant -r admin
	#curl -XGET 'http://localhost:9200/'
	#curl -u vagrant -XGET 'http://localhost:9200/'

	#set up SSH Keys for the Logstash-forwarder
	#mkdir -p /etc/pki/tls/certs
	#mkdir /etc/pki/tls/private
	#cd /etc/pki/tls
	#sudo openssl req -x509 -batch -nodes -days 3650 -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
	#cp /vagrant/sys/logstash/01-lumberjack-input.conf /etc/logstash/conf.d/01-lumberjack-input.conf 
	#cp /vagrant/sys/logstash/10-syslog.conf /etc/logstash/conf.d/10-syslog.conf
	#service logstash restart

	# TODO get password inserted automaticaly
	#echo "password for User vagrant = vagrant"
	#scp /etc/pki/tls/certs/logstash-forwarder.crt vagrant@127.0.0.1:/tmp

	#install logstash-forwarder
	#cd /home/elasticsearch
	#cp /vagrant/sys/logstash/forwarder/logstash-forwarder /etc/logstash-forwarder
	#echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | sudo tee /etc/apt/sources.list.d/logstashforwarder.list
	#wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
	#apt-get update
	#apt-get install -y --force-yes logstash-forwarder
	#wget https://assets.digitalocean.com/articles/logstash/logstash-forwarder_0.3.1_i386.deb
	#dpkg -i logstash-forwarder_0.3.1_i386.deb
	#cd /etc/init.d/
	#wget https://raw.githubusercontent.com/elasticsearch/logstash-forwarder/a73e1cb7e43c6de97050912b5bb35910c0f8d0da/logstash-forwarder.init -O logstash-forwarder
	#chmod +x logstash-forwarder
	#update-rc.d logstash-forwarder defaults

	#mkdir -p /etc/pki/tls/certs
	#cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/
	#service logstash-forwarder restart

	#install kibana
	cd /home/elasticsearch
	wget "https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz"
	tar -zxf kibana-*-linux-x64.tar.gz
	cd kibana*
	screen -dmS kibana ./bin/kibana

	#install Nginx
	cd /vagrant
	apt-get install -y --force-yes php5-fpm
	cp /vagrant/sys/php/php.ini /etc/php5/fpm/php.ini
	service php5-fpm restart

	apt-get install -y --force-yes nginx
	cp /vagrant/sys/nginx/default /etc/nginx/sites-available/default
	apt-get install -y --force-yes apache2-utils
	#htpasswd -c /etc/nginx/conf.d/kibana.178.62.66.75.htpasswd vagrant
	ln -s /vagrant/frames /usr/share/nginx/www/frames
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
	pip install selenium

	# install selenium
	cd /vagrant
	echo "RAC: INSTALLING SELENIUM SERVER"
	wget "https://selenium.googlecode.com/files/selenium-server-standalone-2.39.0.jar"
	screen -dmS selenium java -jar selenium-server-standalone-2.39.0.jar

	#clean up
	echo "RAC: CLEANING UP...."
	rm -rf /home/develop/packages/*.tar.gz
	#rm -rf /vagrant/*.deb
	#rm -rf /vagrant/elasticsearch

fi

echo "RAC: INSTALL COMPLETE"
echo "RAC: to enter the vagrant use -> vagrant ssh"