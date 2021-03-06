

VARS1="HOME=|USER=|MAIL=|LC_ALL=|LS_COLORS=|LANG="
VARS2="HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_="
VARS="${VARS1}|${VARS2}"
```
docker exec agent1 sh -c "env | egrep -v '^(${VARS})' >> /etc/environment"
```
#### Example of declarative pipeline and ways of working witn env vars
```
pipeline {
    agent any
    
    environment{
        USER_NAME = "Joe"
        USER_ID = 42 //string value
    }
    
    stages{
        stage("List env Vars"){
            steps{
                echo "--- Watching ENV Vars ---"
                sh "printenv | sort"
            }
        }
        stage("Using env Vars"){
            environment{
                USER_PATH = "/home/joe"
                USER_ID = 24
            }
            steps{
                echo "BUILD_NUMBER=${env.BUILD_NUMBER}" //groovy code, double quotes, groovy interpolation
                sh 'echo BUILD_NUMBER = $BUILD_NUMBER'
                echo "Current user is ${env.USER_NAME} with ID ${env.USER_ID}(type: ${env.USER_ID.class})"
                echo "Current user path is ${env.USER_PATH}"
                script{
                    env.USER_GROUP = "users"
                    env.RUN_NEXT = "true"
                }
                sh 'echo Current user group is $USER_GROUP'
                withEnv(["USER_PWD=Secret", "USER_IS_ADMIN=false", "USER_NAME=Bob"]){
                    sh 'echo Current user password is $USER_PWD'
                    sh 'echo Is current user Admin? $USER_IS_ADMIN'
                    echo "Current user is ${env.USER_NAME}" //use overriden var              
                }
            }
        }
        stage("Using bolean vars"){
            environment{
                COUNT_FILES = sh(script:  "ls -la /tmp | tail -n +4 | wc -l", returnStdout: true).trim()
                SOME_VALUE = "${someFunction() ?: ''}" //groovy string, unset var
            }
            when{
                environment name: "RUN_NEXT", value: "true"
                //expression{                    env.RUN_NEXT.toBoolean() == true                }
            }
            steps{
                echo "Running stage triggered with boolean var"
                echo "There are ${env.COUNT_FILES} files in /tmp"
                echo "Some value is ${env.SOME_VALUE} of type ${env.SOME_VALUE?.class}"
            }
            
        }
    }
}
def someFunction(){
    return null
}
```

#### run agent and control in one network
```
docker run -d --rm --name=agent1 --network jenkins -p 23:22 -e "JENKINS_AGENT_SSH_PUBKEY=$(cat ~/.ssh/jenkins_agent_key.pub)" jenkins/ssh-agent:alpine
```
```
docker run -p 8080:8080 -p 50000:50000 --rm --name control1 --network jenkins -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11
```
```
mkdir .ssh
touch .ssh/authorized_keys


chmod 644 .ssh/authorized_keys
chown  jenkins .ssh/authorized_keys  
```
/usr/local/openjdk-11/bin/java

JENKINS_AGENT_SSH_PUBKEY=ssh-rsa AAAAB3Nz

```
docker run -d --rm --name=agent1  jenkins/ssh-agent:jdk11 "ssh-rsa AAAAB3NzaC1yc2EAAAA"
```
#### getting access to local docker daemon to let issue docker ps
```
docker run -p 8080:8080 -p 50000:50000 --rm --privileged --name control1 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:lts-jdk11
```
```
docker run --group-add $(getent group docker | cut -d: -f3) -p 8080:8080 -p 50000:50000 --rm --privileged=true --name control1 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:lts-jdk11
```

cd /var/lib/docker/volumes/jenkins_home/

```
docker service create \
     --name secretsrv \
     --replicas 1 \
     --network jenkins \
     --secret source=mysecret,target=mysql_root_password \
     --secret source=mysql_password,target=mysql_password \
     -e PASSWORD="/run/secrets/PASSWORD" \
     jnknspipehttpd:latest
```
```
docker service create \
     --name secretsrv \
     --replicas 1 \
     -e PASSWORD="/run/secrets/PASSWORD" \
     -p 80
     jnknspipehttpd:latest
```
```
docker service create --name secretsrv --secret source=PASSWORD,target=passw -e PASSWORD="/run/secrets/passw" --replicas 1 -p 80   jnknspipehttpd:latest sh -c "/usr/sbin/httpd -f /etc/apache2/httpd.conf -D FOREGROUND && PASSWORD=$(cat /run/secrets/passw)"

echo "QWERTY!" | docker secret create PASSWORD -
```
