FROM alpine
ENV DEVOPS="Yauhen"
RUN export DEVOPS
RUN apk add --no-cache apache2
WORKDIR /var/www/localhost/htdocs

RUN echo "<html><body><h1>It PassEnv ${DEVOPS}</h1></body></html>" > /var/www/localhost/htdocs/index.html
#RUN echo "<html><body> <meta http-equiv="refresh" content="0; url=/cgi-bin/printenv.cgi"/> </body></html>" > /var/www/localhost/htdocs/index.html

COPY httpd.conf /etc/apache2/httpd.conf
#RUN echo "<html><!--#echo var="DEVOPS" -->" > /var/www/localhost/htdocs/index.shtml


#RUN echo "<pre> <!--#exec cmd="ls" --> </pre> " >> /var/www/localhost/htdocs/index.shtml

#RUN echo "<!--#include virtual="/cgi-bin/printenv" -->"  >> /var/www/localhost/htdocs/index.shtml
#RUN echo "</html>" >> /var/www/localhost/htdocs/index.shtml
#COPY htaccess /var/www/localhost/htdocs/.htaccess
#RUN echo "XBitHack on" >> /var/www/localhost/htdocs/.htaccess


#CMD chmod +x /var/www/localhost/htdocs/index.shtml
EXPOSE 80
CMD ["/usr/sbin/httpd", "-f", "/etc/apache2/httpd.conf", "-DFOREGROUND"]

