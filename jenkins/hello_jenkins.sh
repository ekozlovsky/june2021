#!/bin/sh

PASSWORD=$(/run/secrets/passw)
/usr/sbin/httpd -f /etc/apache2/httpd.conf -D FOREGROUND
