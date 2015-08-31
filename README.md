# Roastbeef and Champagne ELK
##### Elasticsearch dev vagrant<br>

## The Master Branch :)

### Contents
* Elasticsearch 1 node
* Elasticsearch Marvel
* Elasticsearch Kibana
* Elasticsearch Logstash
* Python 2.7 + packages

### Commands

#### builds:


#### runs:

* start all (ELK): /vagrant/start_all.sh
* start index syslogs to Logstash: /vagrant/run_logstash_config.sh
* start Kibana: cd /home/elasticsearch/kibana*; screen -dmS kibana ./bin/kibana
* start Elasticsearch only: /etc/init.d/elasticsearch start

### Links

* elasticsearch node: http://localhost:9200/
* elasticsearch Marvel: http://localhost:9200/_plugin/marvel/
* elasticsearch Kibana: http://localhost:5601

### Cluster setup

* screen -dmS el /usr/share/elasticsearch/bin/elasticsearch