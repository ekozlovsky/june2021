## Redmine web application with MySQL database 
## Deployment in Kubernetes with Jenkins

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
