FROM jenkins/ssh-agent:jdk11
RUN mkdir /home/jenkins/.ssh 
COPY key  /home/jenkins/.ssh/authorized_keys
RUN chmod 644 /home/jenkins/.ssh/authorized_keys
RUN chown  jenkins /home/jenkins/.ssh/authorized_keys  
EXPOSE 22

