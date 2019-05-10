#!/bin/bash
apk add --no-cache \
    php5-apcu \
    php5-bcmath \
    php5-bz2 \
    php5-calendar \
    php5-cli \
    php5-common \
    php5-ctype \
    php5-dom \
    php5-exif \
    php5-gd \
    php5-iconv \
    php5-intl \
    php5-json \
    php5-mbstring \
    php5-mcrypt \
    php5-pcntl \
    php5-pdo \
    php5-posix \
    php5-session  \
    php5-simplexml \
    php5-tokenizer \
    php5-xml \
    php5-xmlreader \
    php5-xmlwriter \
    php5-xsl \
    php5-zip \
    php5-zlib \
    ;

sed -i \
    -e "s/^expose_php.*/expose_php = Off/" \
    -e "s/^;date.timezone.*/date.timezone = UTC/" \
    -e "s/^memory_limit.*/memory_limit = 256M/" \
    -e "s/^max_execution_time.*/max_execution_time = 150/" \
    -e "s/^post_max_size.*/post_max_size = 512M/" \
    -e "s/^upload_max_filesize.*/upload_max_filesize = 512M/" \
    -e "s/^allow_url_fopen.*/allow_url_fopen = On/" \
    -e "s/^;always_populate_raw_post_data.*/always_populate_raw_post_data = -1/" \
    -e "s/^;sendmail_path.*/;sendmail_path = opensmtpd/" \
    /etc/php5/php.ini
