#!/bin/bash
apk add --no-cache \
                  php7-fpm \
                  ;
cp /temp_docker/php-fpm/configs/php7/php-fpm.conf /etc/php7/php-fpm.conf
touch /var/log/fpm-php.www.log
chown -R www-data:www-data /var/log/fpm-php.www.log

sed -i \
    -e "s/^listen.*/listen = 8000/" \
    /etc/php7/php-fpm.conf
