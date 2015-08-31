#!/usr/bin/env bash
# Roastbeef & Champagne dev Vagrant
#
# Cory Kehoe
# Eric Heun
# roastbeefandchampagne@gmail.com
# 2015

killall -9 python
killall -9 java
service elasticsearch restart
service logstash restart
screen -dmS kibana /home/elasticsearch/kibana*/bin/kibana