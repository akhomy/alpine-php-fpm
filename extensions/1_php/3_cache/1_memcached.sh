#!/bin/bash
apk add libmemcached-dev
cd /temp_docker && git clone https://github.com/php-memcached-dev/php-memcached && \
cd php-memcached && git checkout php7 && git pull && \
phpize && \
./configure --with-libmemcached-dir=no --disable-memcached-sasl && \
make && \
make install && \
echo 'extension=memcached.so' > /etc/php7/conf.d/memcached.ini
