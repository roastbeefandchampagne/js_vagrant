#/opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-simple.conf
#/opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-minecraft.conf

#screen -dmS install /opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-install.conf
screen -dmS daemon /opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-daemon.conf
screen -dmS hardware /opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-hardware.conf
screen -dmS minecraft /opt/logstash/bin/logstash -f /vagrant/sys/logstash/logstash-minecraft.conf
