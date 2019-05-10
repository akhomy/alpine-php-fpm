#!/bin/bash
apk add redis
cd /temp_docker && wget https://github.com/phpredis/phpredis/archive/$PHP_REDIS_VERSION.tar.gz
cd /temp_docker && tar -xvzf $PHP_REDIS_VERSION.tar.gz
cd /temp_docker && cd phpredis-$PHP_REDIS_VERSION && phpize
cd /temp_docker && cd phpredis-$PHP_REDIS_VERSION && ./configure
cd /temp_docker && cd phpredis-$PHP_REDIS_VERSION && make
cd /temp_docker && cd phpredis-$PHP_REDIS_VERSION && make test
cp /temp_docker/phpredis-$PHP_REDIS_VERSION/modules/redis.so /usr/lib/php5/modules/redis.so && \
    echo "extension = redis.so" > /etc/php5/conf.d/redis.ini
