FROM alpine
ENV DEVOPS="Yauhen"
RUN export DEVOPS && apk add --no-cache apache2
WORKDIR /var/www/localhost/htdocs
RUN echo "<html><body><h1>It PassEnv ${DEVOPS}</h1></body></html>" > /var/www/localhost/htdocs/index.html
#COPY httpd.conf /etc/apache2/httpd.conf
EXPOSE 80
CMD ["/usr/sbin/httpd", "-f", "/etc/apache2/httpd.conf", "-DFOREGROUND"]
#checking
