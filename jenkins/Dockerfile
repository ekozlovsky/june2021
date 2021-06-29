FROM httpd:2.4-alpine
COPY index.html /usr/local/apache2/htdocs/
COPY hello_jenkins.sh hello_jenkins.sh
CMD chmod +x hello_jenkins.sh
CMD hello_jenkins.sh
