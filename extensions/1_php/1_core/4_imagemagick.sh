#!/bin/bash
sed -ie 's/-n//g' /usr/bin/pecl && \
    yes | pecl install imagick && \
    echo 'extension=imagick.so' > /etc/php5/conf.d/imagick.ini && \
    rm -rf /tmp/pear
