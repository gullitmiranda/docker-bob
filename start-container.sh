#!/bin/sh
docker run -d --name apache -p 80:80 -v $1:/app -v $2:/sites-available -v /home/lg/docker/apache/logs:/logs --link mysql:mysql --link memcached:memcached --link solr:solr tutum/apache-php