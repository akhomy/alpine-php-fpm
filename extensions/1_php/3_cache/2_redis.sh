#!/bin/bash
apk add redis
cd /temp_docker && git clone https://github.com/phpredis/phpredis.git && cd phpredis && \
git checkout php7-ipv6 && git pull && \
phpize  && \
./configure  && \
make && \
make install && \
echo 'extension=redis.so' > /etc/php7/conf.d/redis.ini

