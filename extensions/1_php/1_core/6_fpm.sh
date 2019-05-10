#!/bin/bash
apk add --no-cache \
                  php5-fpm \
                  ;
cp /temp_docker/php-fpm/configs/php5/php-fpm.conf /etc/php5/php-fpm.conf
touch /var/log/fpm-php.www.log
chown -R www-data:www-data /var/log/fpm-php.www.log

sed -i \
    -e "s/^listen.*/listen = 8000/" \
    /etc/php5/php-fpm.conf
