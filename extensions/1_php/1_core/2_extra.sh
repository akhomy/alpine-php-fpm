#!/bin/bash
apk add --no-cache \
    php7-curl \
    php7-dev \
    php7-ftp \
    php7-imap \
    php7-ldap \
    php7-opcache \
    php7-openssl \
    php7-pear \
    php7-phar \
    php7-soap \
    php7-sockets \
    ;
pecl channel-update pecl.php.net
