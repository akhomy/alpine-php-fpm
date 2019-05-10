#!/bin/bash
sed -ie 's/-n//g' /usr/bin/pecl && \
    yes | pecl install uploadprogress && \
    echo 'extension=uploadprogress.so' > /etc/php5/conf.d/uploadprogress.ini && \
    rm -rf /tmp/pear
