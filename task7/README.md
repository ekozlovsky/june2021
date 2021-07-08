## zabbix
### how to install zabbix
[zabbix documentation] (https://www.zabbix.com/download?zabbix=5.2&os_distribution=ubuntu&os_version=20.04_focal&db=mysql&ws=apache)

```
sudo rpm -ivh https://repo.zabbix.com/zabbix/5.2/rhel/5/i386/zabbix-agent-5.2.7-1.el5.i386.rpm
wget https://cdn.zabbix.com/zabbix/binaries/stable/5.2/5.2.7/zabbix_agent-5.2.7-linux-3.0-amd64-static.tar.gz
```
 

### start zabbix agent with docker
```
docker run --name some-zabbix-agent -e ZBX_HOSTNAME="some-hostname" -e ZBX_SERVER_HOST="some-zabbix-server" -d zabbix/zabbix-agent:tag
docker run --name some-zabbix-agent -e ZBX_HOSTNAME="localhost" -e ZBX_SERVER_HOST="134.17.145.199" -d zabbix/zabbix-agent:alpine
docker run --name some-zabbix-agent1 --rm  -p "10050:10050" -e ZBX_HOSTNAME="localhost" -e ZBX_SERVER_HOST="134.17.145.166" -d zabbix/zabbix-agent:alpine-latest
```

### linux cpu load
```
dd if=/dev/urandom | bzip2 -9 > /dev/null
```


```
 2002  docker run --rm --name es01-test --net elastic -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.13.2
 2003  docker rm es01-test 

 2000  docker run --rm -it --name logstash01 --net elastic -v $(pwd)/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.13.2

 2002  docker run --name kib01-test --net elastic -p 5601:5601 -e "ELASTICSEARCH_HOSTS=http://172.19.0.2:9200" docker.elastic.co/kibana/kibana:7.13.2
 2003  docker rm kib01-test
```

--log-driver gelf –-log-opt gelf-address=udp://localhost:12201
-p 12201:12201/udp

### run logstash container with gelf log driver
```
docker run --rm -it --name logstash01 --net elastic -p 12201:12201/udp --log-driver gelf –-log-opt gelf-address=udp://localhost:12201  -v $(pwd)/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.13.2

docker run --rm -it --name logstash01 --net elastic -p 127.0.0.1:12201:12201/udp --log-driver gelf --log-opt gelf-address=udp://localhost:12201  -v $(pwd)/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.13.2

```

### logstash pipeline config string pipeline.yml
  config.string: "input { generator {} } filter { sleep { time => 1 } } output { stdout { codec => dots } }"


config.string: "input { gelf {} } filter { json { source => "message" } date { match => ["timestamp", "UNIX"] } mutate { remove_field => [ "command", "created" ] } }  output { elasticsearch { hosts => ["172.19.0.2"] } stdout { } }"

config.string: "input { gelf {} } filter { json { source => "message" } date { match => ["timestamp", "UNIX"] }  output { elasticsearch { hosts => ["172.19.0.2"] } stdout { } }"

config.string: "input { gelf {} } filter { json { source => "message" }  output { elasticsearch { hosts => ["172.19.0.2"] } stdout { } }"
    
    command: -e 'input { gelf {} } filter { json { source => "message" } date { match => ["timestamp", "UNIX"] } mutate { remove_field => [ "command", "created" ] } }  output { elasticsearch { hosts => ["elasticsearch"] } stdout { } }'




### filebeat in docker
```
docker pull docker.elastic.co/beats/filebeat:7.13.3

docker run docker.elastic.co/beats/filebeat:7.13.3 setup -E setup.kibana.host=kibana:5601 -E output.elasticsearch.hosts=["elasticsearch:9200"] 
docker run docker.elastic.co/beats/filebeat:7.13.3 setup -E setup.kibana.host=kibana:5601 -E output.elasticsearch.hosts=["elasticsearch:9200"] 
```
```
docker run -d \
  --name=filebeat \
  --user=root \
  --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  docker.elastic.co/beats/filebeat:7.13.3 filebeat -e -strict.perms=false \
  -E output.elasticsearch.hosts=["elasticsearch:9200"]
```


```
input {
    gelf {
        codec => multiline {
            pattern => "^%{TIMESTAMP_ISO8601} "
            negate => true
            what => "previous"
        }
    }
}
```
```
output {
  elasticsearch {
    hosts => "elasticsearch:9200"
  }
}
output {
  elasticsearch {
    hosts => ["http://172.19.0.2:9200"]
    index => "gelf-%{+YYYY.MM.dd}"
  }
}


 output { file {  path => "/var/log/logstash/%{+yyyy-MM-dd-HH}/%{container_name}.log" } }
   config.string: "input { gelf {} } filter { sleep { time => 1 } } output { file {  path => "/var/log/logstash/%{+yyyy-MM-dd-HH}/%{container_name}.log" } }"

```

  config.string: "input { gelf {} } filter { sleep { time => 1 } } output { stdout { codec => dots } }"
  config.string: "input { gelf {} } filter { sleep { time => 1 } } output { elasticsearch { hosts => "172.19.0.2:9200" } }"
    config.string: "input { gelf {} } filter { sleep { time => 1 } } output { elasticsearch {hosts => ["http://172.19.0.2:9200"] index => "gelf-%{+YYYY.MM.dd}"} }"
  
  
```
  config.string: "input { gelf { port => 12201 } } filter { sleep { time => 1 } } output { stdout {   } }"
```  
```
output {
  if [type] == "docker" {
    elasticsearch { hosts => ["elasticsearch:9200"] }
    stdout { codec => rubydebug }
  }
}
  if [type] == "docker" { elasticsearch { hosts => ["elasticsearch:9200"] } stdout { codec => rubydebug }
  }
```


```
docker run --rm --name es01-test --net elastic -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.13.2

docker run --rm -it --name logstash01 --net elastic -p 127.0.0.1:12201:12201/udp --log-driver gelf --log-opt gelf-address=udp://localhost:12201  -v $(pwd)/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.13.2

docker run --rm --name kib01-test --net elastic -p 5601:5601 -e "ELASTICSEARCH_HOSTS=http://172.19.0.2:9200" docker.elastic.co/kibana/kibana:7.13.2
```

### elasticsearch
```
docker run --rm --name es01-test --net elastic --ip 172.19.0.2 -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.13.2
```

### logstash
```
docker run --rm -it --name logstash01 --net elastic -p 127.0.0.1:12201:12201/udp --log-driver gelf --log-opt gelf-address=udp://localhost:12201  -v $(pwd)/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.13.2

docker run --rm -it --name logstash01 --net elastic --ip 172.19.0.3 -v $(pwd)/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.13.2

```

### kibana
```
docker run --rm --name kib01-test --net elastic --ip 172.19.0.4 -p 5601:5601 -e "ELASTICSEARCH_HOSTS=http://172.19.0.2:9200" docker.elastic.co/kibana/kibana:7.13.2
```

### filebeat 
```
docker run --rm -it --name=filebeat --user=root --net elastic --ip 172.19.0.5 -p 5044:5044 --volume="$(pwd)/settings/filebeat.yml:/usr/share/filebeat/filebeat.yml:ro" --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" --volume="/var/run/docker.sock:/var/run/docker.sock:ro" docker.elastic.co/beats/filebeat:7.13.3 filebeat -e -strict.perms=false -E output.elasticsearch.hosts=["172.19.0.2:9200"]

```
