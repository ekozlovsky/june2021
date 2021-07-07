## zabbix
### how to install zabbix
[zabbix documentation] (https://www.zabbix.com/download?zabbix=5.0&os_distribution=debian&os_version=10_buster&db=mysql)

```
sudo rpm -ivh https://repo.zabbix.com/zabbix/5.2/rhel/5/i386/zabbix-agent-5.2.7-1.el5.i386.rpm
wget https://cdn.zabbix.com/zabbix/binaries/stable/5.2/5.2.7/zabbix_agent-5.2.7-linux-3.0-amd64-static.tar.gz
```
 

### start zabbix agent with docker
```
docker run --name some-zabbix-agent -e ZBX_HOSTNAME="some-hostname" -e ZBX_SERVER_HOST="some-zabbix-server" -d zabbix/zabbix-agent:tag
docker run --name some-zabbix-agent -e ZBX_HOSTNAME="localhost" -e ZBX_SERVER_HOST="134.17.145.166" -d zabbix/zabbix-agent:alpine
docker run --name some-zabbix-agent1 --rm  -p "10050:10050" -e ZBX_HOSTNAME="localhost" -e ZBX_SERVER_HOST="134.17.145.166" -d zabbix/zabbix-agent:alpine-latest
```

### linux cpu load
```
dd if=/dev/urandom | bzip2 -9 > /dev/null
```
### amazon images
