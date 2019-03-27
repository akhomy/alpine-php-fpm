#!/bin/bash
apk add --no-cache \
    php7-apcu \
    php7-bcmath \
    php7-bz2 \
    php7-calendar \
    php7-cli \
    php7-common \
    php7-ctype \
    php7-dom \
    php7-exif \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-pcntl \
    php7-pdo \
    php7-posix \
    php7-session  \
    php7-simplexml \
    php7-tokenizer \
    php7-xml \
    php7-xmlreader \
    php7-xmlwriter \
    php7-xsl \
    php7-zip \
    php7-zlib \
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
    /etc/php7/php.ini
