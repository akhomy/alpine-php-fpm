#!/bin/bash
mkdir /var/xdebug && mkdir /var/xdebug/logs && chmod -R +x /var/xdebug
cd /temp_docker && wget https://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz
cd /temp_docker && tar -xvzf xdebug-${XDEBUG_VERSION}.tgz
cd /temp_docker && cd xdebug-${XDEBUG_VERSION} && phpize
cd /temp_docker && cd xdebug-${XDEBUG_VERSION} && ./configure
cd /temp_docker && cd xdebug-${XDEBUG_VERSION} && make
cd /temp_docker && cd xdebug-${XDEBUG_VERSION} && make test
cd /temp_docker && cd xdebug-${XDEBUG_VERSION} && echo ";zend_extension = xdebug.so" > /etc/php5/conf.d/xdebug.ini
cp /temp_docker/xdebug-${XDEBUG_VERSION}/modules/xdebug.so /usr/lib/php5/modules/xdebug.so
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
    /etc/php5/conf.d/xdebug.ini
