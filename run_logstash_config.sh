#/opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-simple.conf
#/opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-minecraft.conf

screen -dmS tcp /opt/logstash/bin/logstash -f /etc/logstash/conf.d/logstash-server.conf
#screen -dmS hardware /opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-hardware.conf
#screen -dmS minecraft /opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-minecraft.conf
