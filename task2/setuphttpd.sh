#!/bin/bash

yum update -y
yum install -y httpd
os=$(uname -a)
echo '<!DOCTYPE html>' >> /var/www/html/index.html
echo '<html>' >> /var/www/html/index.html
echo '<head>' >> /var/www/html/index.html
echo '    <title>Hello World!</title>' >> /var/www/html/index.html
echo '</head>' >> /var/www/html/index.html
echo '<body>' >> /var/www/html/index.html
echo '<h1>Hello World</h1>' >> /var/www/html/index.html
echo "<h1>${os}</h1>" >> /var/www/html/index.html
echo '</body>' >> /var/www/html/index.html
echo '</html>' >> /var/www/html/index.html

systemctl start httpd
systemctl enable httpd
