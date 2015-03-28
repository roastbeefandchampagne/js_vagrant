#!/usr/bin/env bash
# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015
echo "--RAC: Pyramid DEV VAGRANT INSTALL--"
echo "--Python 2.7 + Pyramid--"

#hostname roastbeefandchampagne.com

apt-get update
apt-get install -y --force-yes git

apt-get install -y --force-yes screen


apt-get update
apt-get install -y build-essential


echo "RAC: INSTALLING PYTHON 2.7"
apt-get install python2.7

echo "RAC: INSTALLING PYTHON PACKAGES"
apt-get install -y --force-yes libmysqlclient-dev
apt-get install -y --force-yes python-dev

mkdir -p /home/develop/packages
cd /home/develop/packages
wget http://pypi.python.org/packages/source/p/pip/pip-0.7.2.tar.gz
tar xzf pip-0.7.2.tar.gz
cd pip-0.7.2
python setup.py install

pip install MySQL-python
pip install feedparser
pip install elasticsearch
pip install pygoogle
pip install requests

echo "RAC: INSTALLING Pyramid 1.5.4"
easy_install "pyramid==1.5.4"
cd /vagrant
pcreate -s starter new
cd new
python setup.py develop

echo "RAC: CLEANING UP...."
rm -rf /home/develop/packages/*.tar.gz


echo "RAC: INSTALL COMPLETE"
echo "RAC: to enter the vagrant use -> vagrant ssh"