#lordius/alpine-php_fpm
FROM lordius/alpine-base:edge
LABEL maintainer=andriy.khomych@gmail.com
# Envs
ENV XDEBUG_VERSION 2.6.0
# Drush version
ENV DRUSH_VERSION 8.x
# Update packages list
RUN apk --no-cache update
# Recreate user with correct params
RUN set -e && \
	addgroup -g 1000 -S www-data && \
	adduser -u 1000 -D -S -s /bin/bash -G www-data www-data && \
	sed -i '/^www-data/s/!/*/' /etc/shadow

# Install mysql-client, necessary for drush
RUN apk add --no-cache mysql-client
# Add memcached, redis
RUN apk add libmemcached-dev redis
# Create /temp_dir for using
RUN mkdir /temp_docker && chmod -R +x /temp_docker && cd /temp_docker
# Install php-fpm
RUN apk add --no-cache php7-fpm
# Install base php libs
RUN apk add --no-cache php7-dev php7-openssl \
    php7-common php7-ftp php7-gd \
    php7-dom  php7-sockets \
    php7-zlib php7-bz2 php7-pear php7-cli \
    php7-exif php7-phar php7-zip php7-calendar \
    php7-iconv php7-imap php7-soap \
    php7-mbstring php7-bcmath \
    php7-mcrypt php7-curl php7-json \
    php7-opcache php7-ctype php7-xml \
    php7-xsl php7-ldap php7-xmlwriter php7-xmlreader \
    php7-intl php7-tokenizer php7-session  \
    php7-pcntl php7-posix php7-apcu php7-simplexml \
    php7-pdo \
    php7-mysqlnd php7-pdo_mysql php7-mysqli \
    php7-pgsql php7-pdo_pgsql  
# Copy crontab file for use later
COPY crontasks.txt /home
#RUN crontab /home/crontasks.txt

# Configure /etc/postfix/main.cf
RUN echo "relayhost = [$PHP_SENDMAIL_HOST]:$PHP_SENDMAIL_PORT" >> /etc/postfix/main.cf && \
    echo "myhostname = $PHP_SENDMAIL_HOST" >> /etc/postfix/main.cf && \
    echo "inet_interfaces = all" >> /etc/postfix/main.cf && \
    echo "recipient_delimiter = +" >> /etc/postfix/main.cf

# Install uploadprogress
RUN cd /temp_docker && git clone https://github.com/php/pecl-php-uploadprogress.git && cd pecl-php-uploadprogress && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    echo 'extension=uploadprogress.so' > /etc/php7/conf.d/uploadprogress.ini

# Install xdebug
RUN mkdir /var/xdebug && chmod -R +x /var/xdebug
RUN cd /temp_docker && wget https://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz
RUN cd /temp_docker && tar -xvzf xdebug-$XDEBUG_VERSION.tgz
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && phpize
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && ./configure
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && make
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && make test
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && echo ";zend_extension = xdebug.so" > /etc/php7/conf.d/xdebug.ini
RUN cp /temp_docker/xdebug-$XDEBUG_VERSION/modules/xdebug.so /usr/lib/php7/modules/xdebug.so
RUN sed -i \
    -e "$ a xdebug.default_enable = 0" \
    -e "$ a xdebug.remote_enable = 1" \
    -e "$ a xdebug.remote_handler = dbgp" \
    -e "$ a xdebug.remote_port = 9000" \
    -e "$ a xdebug.remote_autostart = 1" \
    -e "$ a xdebug.remote_connect_back = 1" \
    -e "$ a xdebug.max_nesting_level = 256" \
    -e "$ a xdebug.profiler_enable = 0" \
    -e "$ a xdebug.profiler_enable_trigger = 1" \    
    -e "$ a xdebug.profiler_output_dir = /var/xdebug" \        
    /etc/php7/conf.d/xdebug.ini

# Install memcached
RUN cd /temp_docker && git clone https://github.com/php-memcached-dev/php-memcached && \
    cd php-memcached && git checkout php7 && git pull && \
    phpize && \
    ./configure --with-libmemcached-dir=no --disable-memcached-sasl && \
    make && \
    make install && \
    echo 'extension=memcached.so' > /etc/php7/conf.d/memcached.ini

# Install php-redis
RUN cd /temp_docker && git clone https://github.com/phpredis/phpredis.git && cd phpredis && \
    git checkout php7-ipv6 && git pull && \
    phpize  && \
    ./configure  && \
    make && \
    make install && \
    echo 'extension=redis.so' > /etc/php7/conf.d/redis.ini

# Install MongoDB PHP extension
RUN sed -ie 's/-n//g' /usr/bin/pecl && \
    yes | pecl install mongodb && \
    echo 'extension=mongodb.so' > /etc/php7/conf.d/mongodb.ini && \
    rm -rf /tmp/pear

# Configure php-fpm by copy our config files
RUN rm /etc/php7/php-fpm.conf
ADD configs/php7/php-fpm.conf /etc/php7/php-fpm.conf
RUN touch /var/log/fpm-php.www.log
RUN chown -R www-data:www-data /var/log/fpm-php.www.log

# Configure php-fpm.conf
RUN sed -i \
    -e "s/^listen.*/listen = 8000/" \
    /etc/php7/php-fpm.conf

# Configure php.ini
RUN sed -i \
    -e "s/^expose_php.*/expose_php = Off/" \
    -e "s/^;date.timezone.*/date.timezone = UTC/" \
    -e "s/^memory_limit.*/memory_limit = 256M/" \
    -e "s/^max_execution_time.*/max_execution_time = 150/" \
    -e "s/^post_max_size.*/post_max_size = 512M/" \
    -e "s/^upload_max_filesize.*/upload_max_filesize = 512M/" \
    -e "s/^allow_url_fopen.*/allow_url_fopen = On/" \
    -e "s/^;always_populate_raw_post_data.*/always_populate_raw_post_data = -1/" \
    -e "s/^;sendmail_path.*/;sendmail_path = opensmtpd/" \
    /etc/php7/php.ini && \

    # Some git tweaks
    git config --global user.name "Lordius PHP-FPM" && \
    git config --global user.email "admin@lordius.com" && \
    git config --global push.default current

# Add setup drush and composer script
COPY setup_extensions/composer_drush.sh /temp_docker/composer_drush.sh
RUN chmod -R +x /temp_docker && cd /temp_docker && bash /temp_docker/composer_drush.sh $DRUSH_VERSION
# Clean trash
RUN  rm -rf /var/lib/apt/lists/* && \
     rm -rf /var/cache/apk/* && \
     rm -rf /var/www/localhost/htdocs/* && \
     rm -rf /temp_docker

# Create /temp_configs_dir for use
RUN mkdir /temp_configs_dir && chmod -R +x /temp_configs_dir && cd /temp_configs_dir

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && mkdir -p /var/www/localhost/htdocs && \
chown -R www-data:www-data /var/www/ && \
chown -R www-data:www-data /var/log/
WORKDIR /var/www/localhost/htdocs
ADD docker-entrypoint.sh docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
