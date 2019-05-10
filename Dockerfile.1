#lordius/alpine-php_fpm:php-5
FROM lordius/alpine-base:v3.4
MAINTAINER lordius<andriy.khomych@gmail.com>
# Envs
ENV XDEBUG_VERSION 2.4.1
# PHP Redis version
ENV PHP_REDIS_VERSION 2.2.8
# Twig version
ENV TWIG_VERSION v1.24.2
ENV TWIG_PATH Twig-1.24.2
ENV DRUSH_VERSION 8.x
# Recreate user with correct params
RUN set -e && \
  addgroup -g 1000 -S www-data && \
  adduser -u 1000 -D -S -s /bin/bash -G www-data www-data && \
  sed -i '/^www-data/s/!/*/' /etc/shadow
# Install mysql-client, necessary for drush
RUN apk add --no-cache mysql-client
# Install php-fpm
RUN apk add --no-cache php5-fpm
# Install some php libs
RUN apk add --no-cache php5-dev php5-openssl php5-pear \
    php5-common php5-cli php5-ftp php5-gd \
    php5-sockets \
    php5-zlib php5-bz2  php5-pear \
    php5-exif php5-phar php5-zip php5-calendar \
    php5-iconv php5-imap php5-soap php5-memcache \
    php5-bcmath \
    php5-mcrypt php5-curl php5-json \
    php5-opcache php5-ctype \
    php5-xsl php5-ldap php5-xml\
    php5-intl php5-dom php5-xmlreader \
    php5-pcntl php5-posix php5-apcu \
    php5-pdo php5-pdo_mysql php5-mysql php5-mysqli \
    php5-pgsql php5-pdo_pgsql 

# Copy crontab file for using later
COPY crontasks.txt /home
#RUN crontab /home/crontasks.txt

# Create /temp_dir for using
RUN mkdir /temp_docker && chmod -R +x /temp_docker && cd /temp_docker

# Configure /etc/postfix/main.cf
RUN echo "relayhost = [$PHP_SENDMAIL_HOST]:$PHP_SENDMAIL_PORT" >> /etc/postfix/main.cf && \
    echo "myhostname = $PHP_SENDMAIL_HOST" >> /etc/postfix/main.cf && \
    echo "inet_interfaces = all" >> /etc/postfix/main.cf && \
    echo "recipient_delimiter = +" >> /etc/postfix/main.cf

# Install uploadprogress
RUN sed -ie 's/-n//g' /usr/bin/pecl && \
    yes | pecl install uploadprogress && \
    echo 'extension=uploadprogress.so' > /etc/php5/conf.d/uploadprogress.ini && \
    rm -rf /tmp/pear

# Install imagemagick
RUN sed -ie 's/-n//g' /usr/bin/pecl && \
    yes | pecl install imagick && \
    echo 'extension=imagick.so' > /etc/php5/conf.d/imagick.ini && \
    rm -rf /tmp/pear

# Install MongoDB PHP extension
RUN sed -ie 's/-n//g' /usr/bin/pecl && \
    yes | pecl install mongodb && \
    echo 'extension=mongodb.so' > /etc/php5/conf.d/mongodb.ini && \
    rm -rf /tmp/pear

# Install xdebug
RUN cd /temp_docker && wget https://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz
RUN cd /temp_docker && tar -xvzf xdebug-$XDEBUG_VERSION.tgz
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && phpize
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && ./configure
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && make
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && make test
RUN cd /temp_docker && cd xdebug-$XDEBUG_VERSION && echo ";zend_extension = xdebug.so" > /etc/php5/conf.d/xdebug.ini
RUN cp /temp_docker/xdebug-$XDEBUG_VERSION/modules/xdebug.so /usr/lib/php5/modules/xdebug.so

RUN sed -i \
    -e "$ a xdebug.default_enable = 0" \
    -e "$ a xdebug.remote_enable = 1" \
    -e "$ a xdebug.remote_handler = dbgp" \
    -e "$ a xdebug.remote_port = 9000" \
    -e "$ a xdebug.remote_autostart = 1" \
    -e "$ a xdebug.remote_connect_back = 1" \
    -e "$ a xdebug.max_nesting_level = 256" \
    /etc/php5/conf.d/xdebug.ini

# Install PHP-Redis
RUN cd /temp_docker && wget https://github.com/phpredis/phpredis/archive/$PHP_REDIS_VERSION.tar.gz
RUN cd /temp_docker && tar -xvzf $PHP_REDIS_VERSION.tar.gz
RUN cd /temp_docker && cd phpredis-$PHP_REDIS_VERSION && phpize
RUN cd /temp_docker && cd phpredis-$PHP_REDIS_VERSION && ./configure
RUN cd /temp_docker && cd phpredis-$PHP_REDIS_VERSION && make
RUN cd /temp_docker && cd phpredis-$PHP_REDIS_VERSION && make test
RUN cp /temp_docker/phpredis-$PHP_REDIS_VERSION/modules/redis.so /usr/lib/php5/modules/redis.so && \
    echo "extension = redis.so" > /etc/php5/conf.d/redis.ini

# Install Twig
RUN cd /temp_docker && wget https://github.com/twigphp/Twig/archive/$TWIG_VERSION.tar.gz
RUN cd /temp_docker && tar -xvzf $TWIG_VERSION.tar.gz
RUN cd /temp_docker && cd $TWIG_PATH/ext/twig && phpize
RUN cd /temp_docker && cd $TWIG_PATH/ext/twig && ./configure
RUN cd /temp_docker && cd $TWIG_PATH/ext/twig && make
RUN cd /temp_docker && cd $TWIG_PATH/ext/twig && make test
RUN cp /temp_docker/$TWIG_PATH/ext/twig/modules/twig.so /usr/lib/php5/modules/twig.so && \
    echo 'extension=twig.so' > /etc/php5/conf.d/twig.ini


# Configure PHP-FPM by copy our config files
RUN rm /etc/php5/php-fpm.conf
ADD configs/php5/php-fpm.conf /etc/php5/php-fpm.conf
RUN touch /var/log/fpm-php.www.log
RUN chown -R www-data:www-data /var/log/fpm-php.www.log

# Configure php-fpm.conf
RUN sed -i \
    -e "s/^listen.*/listen = 8000/" \
    /etc/php5/php-fpm.conf


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
    /etc/php5/php.ini && \

    # Some git tweaks
    git config --global user.name "Lordius PHP-FPM" && \
    git config --global user.email "admin@lordius.com" && \
    git config --global push.default current

# Add setup drush and composer script
COPY setup_extensions/composer_drush.sh /temp_docker/composer_drush.sh
RUN  chmod -R +x /temp_docker && cd /temp_docker && bash /temp_docker/composer_drush.sh $DRUSH_VERSION
# Clean trash
RUN  rm -rf /var/lib/apt/lists/* && \
     rm -rf /var/cache/apk/* && \
     rm -rf /var/www/localhost/htdocs/* && \
     rm -rf /temp_docker

# Create /temp_configs_dir for using
RUN mkdir /temp_configs_dir && chmod -R +x /temp_configs_dir && cd /temp_configs_dir

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && mkdir -p /var/www/localhost/htdocs && \
chown -R www-data:www-data /var/www/ && \
chown -R www-data:www-data /var/log/
WORKDIR /var/www/localhost/htdocs
ENTRYPOINT ["docker-entrypoint.sh"]
