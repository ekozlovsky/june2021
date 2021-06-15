#!/bin/bash

docker run -dit --name apache-helloworld -p 8080:80 -v $(pwd)/www:/usr/local/apache2/htdocs/ httpd:2.4
