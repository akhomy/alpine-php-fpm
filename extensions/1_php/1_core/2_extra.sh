#!/bin/bash
apk add --no-cache \
    php5-curl \
    php5-dev \
    php5-ftp \
    php5-imap \
    php5-ldap \
    php5-opcache \
    php5-openssl \
    php5-pear \
    php5-phar \
    php5-soap \
    php5-sockets \
    ;
pecl channel-update pecl.php.net
