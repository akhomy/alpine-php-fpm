#!/bin/bash
sed -ie 's/-n//g' /usr/bin/pecl && \
    yes | pecl install mongodb && \
    echo 'extension=mongodb.so' > /etc/php5/conf.d/mongodb.ini && \
    rm -rf /tmp/pear
