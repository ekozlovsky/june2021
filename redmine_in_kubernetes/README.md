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

### Install bundler and rails
```
   sudo gem install bundler
   
   gem install rails --version=5.2.6
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

### Install kubernetes cluster on ubuntu

### Install docker
```
sudo apt update
sudo apt install docker.io
sudo systemctl status docker
```
### install kubernetes
```
sudo apt install apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt install kubeadm kubelet kubectl kubernetes-cni
sudo swapoff -a
```

### What about kubelet on worker node?
```
sudo systemctl enable kubelet
sudo systemctl start kubelet
```

### Init cluster with right flannel network addresses

```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
sudo kubeadm init
```

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

kubectl get pods --all-namespaces
```
### worker nodes

```
kubeadm join 172.31.33.245:6443 --token atcazv.r92cspqceiguz5rx \
	--discovery-token-ca-cert-hash sha256:bbb59bb2dd806b8a28b91cae7978b28285d5c098e04e638da2ffdf2f8dde75f5 
```


