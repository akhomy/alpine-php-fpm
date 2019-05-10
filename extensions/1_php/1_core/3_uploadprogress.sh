#!/bin/bash
 cd /temp_docker && git clone https://github.com/php/pecl-php-uploadprogress.git && cd pecl-php-uploadprogress && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    echo 'extension=uploadprogress.so' > /etc/php7/conf.d/uploadprogress.ini
