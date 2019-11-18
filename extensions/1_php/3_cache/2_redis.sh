#!/bin/bash
apk add redis

cd /temp_docker && wget https://github.com/phpredis/phpredis/archive/5.1.1.tar.gz
cd /temp_docker && tar -xvzf 5.1.1.tar.gz && ls
cd /temp_docker && cd phpredis-5.1.1 && phpize
cd /temp_docker && cd phpredis-5.1.1 && ./configure
cd /temp_docker && cd phpredis-5.1.1 && make
cd /temp_docker && cd phpredis-5.1.1 && make install && \
echo 'extension=redis.so' > /etc/php7/conf.d/redis.ini
cd /temp_docker && cd phpredis-5.1.1 && make test

