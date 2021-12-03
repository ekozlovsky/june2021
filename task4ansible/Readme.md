
#### deploing mysql database with ansible roles
#### please see playbooks in [../task4ansible/roles/deploy_mysql/tasks/main.yml](https://github.com/ekozlovsky/june2021/blob/main/task4ansible/roles/deploy_mysql/tasks/main.yml) 
```
ansible-playbook -i inventory  -vvvv -u ec2-user start_roles.yml -e 'ansible_python_interpreter=/usr/bin/python3' -e 'root_db_pass=<pwd>'
```
```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
python3 -m pip install --user ansible
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum-config-manager --enable epel
```

```
ansible clients  -m ping
ansible-playbook -i inventory -vvv -u ec2-user install-docker.yml
```


#### amazon guide how to install docker on amazon linux
#### https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html

#### some git repo
#### https://gist.github.com/yonglai/d4617d6914d5f4eb22e4e5a15c0e9a03


### Install elasticsearcn

### https://www.elastic.co/guide/en/elasticsearch/reference/7.13/docker.html

### https://www.elastic.co/guide/en/kibana/current/docker.html

```
docker rm es01-test 
docker run --name es01-test --net elastic -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.13.2

docker run --rm -it --net elastic -v $(pwd)/pipeline/:/usr/share/logstash/pipeline/ docker.elastic.co/logstash/logstash:7.13.2
docker run --rm -it --net elastic -v $(pwd)/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.13.2

gedit ./settings/logstash.yml

docker run --name kib01-test --net elastic -p 5601:5601 -e "ELASTICSEARCH_HOSTS=http://172.19.0.2:9200" docker.elastic.co/kibana/kibana:7.13.2
```



