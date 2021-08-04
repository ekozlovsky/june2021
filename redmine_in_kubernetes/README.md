## Redmine web application with MySQL database 
## Deployment in Kubernetes with Jenkins

### Redmine Installation instructions
[See official instruction](https://www.redmine.org/projects/redmine/wiki/redmineinstall)
```
git status
git init
git clone https://github.com/redmine/redmine.git
cd redmine
ruby -v
gem
```
### Install RVM to get ruby 2.7.2
[RVM repo](https://github.com/rvm/ubuntu_rvm)
```
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
sudo usermod -a -G rvm $USER
rvm list
rvm -v
rvm list known
```
### Install ruby 2.7.2
```
rvm install 2.7.2

```

### Install bundler
```
   sudo gem install bundler
   bundle install
   sudo bundle install
   bundle install
```

### solving mysql2 driver installation problem
### to solve mysql2 driver install range of utils seen from original Dockerfile (gcc problem?). see script from redmine github repository 
```
   sudo apt-get install -y --no-install-recommends freetds-dev gcc libmariadbclient-dev libpq-dev libsqlite3-dev make patch \
   gcc
```

## build

```
cd redmine
bundle install --without development test
```

### Use this if you install mysql on the same host with redmine application

```
CREATE DATABASE redmine CHARACTER SET utf8mb4;
CREATE USER 'redmine'@'localhost' IDENTIFIED WITH mysql_native_password BY 'my_password';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
```


