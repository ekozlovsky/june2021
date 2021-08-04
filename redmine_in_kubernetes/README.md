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
### create storage classes, persistent volumes, persistent volume claims
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-sc-redmine-mysql
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-pv-mysql
  labels:
    app: mysql
spec:
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 3Gi
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-sc-redmine-mysql
  local:
    path: /mnt/redmine-mysql # create folder
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - ip-172-31-41-61
```

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-pvc-redmine-mysql
  labels:
    app: mysql
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: local-sc-redmine-mysql
  resources:
    requests:
      storage: 3Gi
```
### create configMap

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: configmap-redmine
data:
  database.yml: |
    production:
      adapter: mysql2
      database: redmine
      host: redmine-mysql
      username: redmine
      password: emptypassword
      # Use "utf8" instead of "utfmb4" for MySQL prior to 5.7.7
      encoding: utf8
```
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: configmap-mysql-redmine
data:
  mysqld.cnf: |
    [mysqld]
    pid-file    = /var/run/mysqld/mysqld.pid
    socket              = /var/run/mysqld/mysqld.sock
    datadir             = /var/lib/mysql
    #log-error  = /var/log/mysql/error.log
    # By default we only accept connections from localhost
    bind-address        = 0.0.0.0
    # Disabling symbolic-links is recommended to prevent assorted security risks
    symbolic-links=0
```
### Create deployment
```
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: redmine-mysql
  labels:
    app: redmine
spec:
  selector:
    matchLabels:
      app: redmine
      tier: mysql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: redmine
        tier: mysql
    spec:
      containers:
      - image: mysql:5.7
        name: mysql
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-pass
              key: password
        ports:
        - containerPort: 3306
          name: mysql
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql
          #        volumeMounts:
        - name: mysql-config
          mountPath: /etc/mysql/mysql.conf.d/mysqld.cnf
          subPath: mysqld.cnf
      volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: local-pvc-redmine-mysql
      - name: mysql-config
        configMap:
          name: configmap-mysql-redmine
          items:
            - key: mysqld.cnf
              path: mysqld.cnf
```
### Create Services
```
apiVersion: v1
kind: Service
metadata:
  name: redmine
  labels:
    app: redmine
spec:
  ports:
    - port: 3000
      targetPort: 3000
      protocol: TCP
      name: redmine
  externalIPs:
    - 172.31.33.245
  selector:
    app: redmine
    tier: frontend
  type: LoadBalancer
```

