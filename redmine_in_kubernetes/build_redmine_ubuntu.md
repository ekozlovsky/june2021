### Redmine Installation instructions
[Installation enstruction](https://www.redmine.org/projects/redmine/wiki/redmineinstall)
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
```
apt-cache search libaio
apt-cache search libaio
apt-cache search libnuma
```
## some attempts to install mysql 5.7.7
```
   sudo dpkg -i mysql-apt-config_0.8.17-1_all.deb 
   sudo apt-get install mysql-server=5.7.7
   sudo dpkg -i mysql-apt-config_0.8.17-1_all.deb 
   sudo apt-get install mysql-server=5.7
   sudo apt-get install mysql-server=5.7.34
```


### Install bundler
```
   sudo gem install bundler
   bundle install
   sudo bundle install
   bundle install
```
## Problems with mysql2 driver
```
   gem install mysql2 -v '0.5.3'
   sudo gem install mysql2 -v '0.5.3'
   sudo bundle install
   bundle install
   sudo gem install mysql2 -v '0.5.3' --source 'https://rubygems.org/ 
   cat /var/lib/gems/2.7.0/extensions/x86_64-linux/2.7.0/mysql2-0.5.3/mkmf.log
   
   bundle install --without development test
 
   sudo gem install mysql2 -v '0.5.3' --source 'https://rubygems.org/'
   gedit /var/lib/gems/2.7.0/extensions/x86_64-linux/2.7.0/mysql2-0.5.3/mkmf.log
   sudo gem install mysql2 
   gedit /var/lib/gems/2.7.0/extensions/x86_64-linux/2.7.0/mysql2-0.5.3/gem_make.out
   sudo gem install mysql2 -v '0.5.3' --source 'https://rubygems.org/'
   bundle install --without development test
   gcc
   make
```

 
### solving mysql2 driver installation problem
### to solve mysql2 driver install range of utils seen from original Dockerfile (gcc problem?). see script from github repository 
```
   sudo apt-get install -y --no-install-recommends freetds-dev gcc libmariadbclient-dev libpq-dev libsqlite3-dev make patch \
   gcc
```

### build

```
bundle install --without development test
```
 
### Install mysql server 8 
```
   systemctl status mysql
   sudo apt-get install mysql-server
```
### create database redmine
### Here were WITH mysql_native_password problem. mysql 8 need this option on redmine database user
```
CREATE DATABASE redmine CHARACTER SET utf8mb4;

CREATE USER 'redmine'@'localhost' IDENTIFIED WITH mysql_native_password BY 'my_password';
CREATE USER 'redmine'@'10.244.2.4' IDENTIFIED WITH mysql_native_password BY 'admin';

GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'10.244.2.4';
```

### Redmine database setup script for kubernetes. Remote MySQL User. Allow remote mysql access.
###   mysql.cnf /etc/mysql/mysql.conf.d/mysqld.cnf, 
### bind-address = ip
### Granting remote access to a user for an existing database 
```
update db set Host=’133.155.44.103' where Db='yourDB';
update user set Host=’133.155.44.103' where user='user1';

update user set Host=’10.244.2.13' where user='redmine';
update user set Host=’%' where user='redmine';
'redmine'@'10.244.2.13'
```
### Use this if you install mysql on the same host with redmine application

```
CREATE DATABASE redmine CHARACTER SET utf8mb4;
CREATE USER 'redmine'@'localhost' IDENTIFIED WITH mysql_native_password BY 'my_password';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
```
### creating redmine database for kubernetes
```
CREATE DATABASE redmine CHARACTER SET utf8mb4;
CREATE USER 'redmine'@'%' IDENTIFIED WITH mysql_native_password BY 'admin';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'%';

SELECT User, Host FROM mysql.user;
SELECT * FROM mysql.user;
```

### after creating database redmine it is needed to db:migrate to fill in redmine database
```
   RAILS_ENV=production bundle exec rake db:migrate --trace
```
```
GRANT ALL PRIVILEGES ON yourDB.* TO user1@’133.155.44.103’ IDENTIFIED BY ‘password1’;

```
### Allow mysql server to accept remote connections
```
cat /etc/mysql/mysql.conf.d/mysqld.cnf
echo 'bind-address = 0.0.0.0' >> /etc/mysql/mysql.conf.d/mysqld.cnf
rm redmine/config/database.yml

```

 
```
sudo mysql -uroot
   sudo mysql -uredmine
   mysql -uredmine -p
```

### Setup redmine DB
``` 
   bundle exec rake generate_secret_token
   RAILS_ENV=production bundle exec rake db:migrate
   sudo
   sudo su
   RAILS_ENV=production bundle exec rake db:migrate --trace
   sudo mysql -uroot

```

```
   RAILS_ENV=production bundle exec rake db:migrate --trace
   RAILS_ENV=production bundle exec rake redmine:load_default_data
```
### Start the application with web server
```
   bundle exec rails server webrick -e production (-u !!!!)
   bundle exec rails server puma -e production
   ls -la (checking permissions on folders)

   bundle exec rails server webrick -e production
   sudo bundle exec rails server webrick -e production
```


