#!/bin/bash
RUN sed -ie 's/-n//g' /usr/bin/pecl && \
    yes | pecl install xdebug && \
    echo 'extension=xdebug.so' > /etc/php7/conf.d/xdebug.ini && \
    rm -rf /tmp/pear
RUN echo ";zend_extension = xdebug.so" > /etc/php7/conf.d/xdebug.ini
sed -i \
    -e "$ a xdebug.default_enable = 0" \
    -e "$ a xdebug.remote_enable = 1" \
    -e "$ a xdebug.remote_handler = dbgp" \
    -e "$ a xdebug.remote_port = 9000" \
    -e "$ a xdebug.remote_autostart = 1" \
    -e "$ a xdebug.remote_connect_back = 1" \
    -e "$ a xdebug.max_nesting_level = 256" \
    -e "$ a xdebug.profiler_enable = 0" \
    -e "$ a xdebug.profiler_aggregate = 0" \
    -e "$ a xdebug.profiler_enable_trigger = 0" \
    -e "$ a xdebug.profiler_output_dir = /var/xdebug/logs" \
    -e "$ a xdebug.profiler_output_name = cachegrind.out.%p" \
    /etc/php7/conf.d/xdebug.ini
