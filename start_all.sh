#!/usr/bin/env bash
# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015

/etc/init.d/elasticsearch start
service logstash start
service logstash-forwarder start
screen -dmS kibana ./vagrant/elasticsearch/kibana-4.0.0-linux-x64/bin/kibana
screen -list