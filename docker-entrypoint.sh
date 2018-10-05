#!/bin/sh
set -e

# Set up specific drush version.
if [ -n "$DRUSH_VERSION" ]; then
    cd /usr/local/src/drush
    git checkout $DRUSH_VERSION
fi

# Copy user defined configs from temp folder to existing.
if [ "$(ls -A /temp_configs_dir)" ]; then
  cp -f -R /temp_configs_dir/* /etc/
fi

if [ -z "$USE_ONLY_CONFIGS" ]; then

  # Show PHP errors.
  if [ "$PHP_SHOW_ERRORS" -eq "1" ]; then
    sed -i 's/^;php_flag[display_errors].*/php_flag[display_errors] = on/' /etc/php7/php-fpm.conf
    sed -i 's/^display_errors.*/display_errors = on/' /etc/php7/php.ini
  fi

  if [ -n "$PHP_FPM_PORT" ]; then
    sed -i 's@^listen.*@'"listen  = ${PHP_FPM_PORT}"'@' /etc/php7/php-fpm.conf
  fi

  if [ -n "$PHP_MEMORY_LIMIT" ]; then
    sed -i 's@^memory_limit.*@'"memory_limit = ${PHP_MEMORY_LIMIT}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_MAX_EXECUTION_TIME" ]; then
    sed -i 's@^max_execution_time.*@'"max_execution_time = ${PHP_MAX_EXECUTION_TIME}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_MAX_FILE_UPLOADS" ]; then
    sed -i 's@^max_file_uploads.*@'"max_file_uploads = ${PHP_MAX_FILE_UPLOADS}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_MAX_INPUT_NESTING_LEVEL" ]; then
    sed -i 's@^;max_input_nesting_level.*@'"max_input_nesting_level = ${PHP_MAX_INPUT_NESTING_LEVEL}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_MAX_INPUT_TIME" ]; then
    sed -i 's@^max_input_time.*@'"max_input_time = ${PHP_MAX_INPUT_TIME}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_MAX_INPUT_VARS" ]; then
    sed -i 's@^; max_input_vars.*@'"max_input_vars = ${PHP_MAX_INPUT_VARS}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_POST_MAX_SIZE" ]; then
    sed -i 's@^post_max_size.*@'"post_max_size = ${PHP_POST_MAX_SIZE}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_UPLOAD_MAX_FILESIZE" ]; then
    sed -i 's@^upload_max_filesize.*@'"upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_ALLOW_URL_FOPEN" ]; then
    sed -i 's@^allow_url_fopen.*@'"allow_url_fopen = ${PHP_ALLOW_URL_FOPEN}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_ALWAYS_POPULATE_RAW_POST_DATA" ]; then
    sed -i 's@^always_populate_raw_post_data.*@'"always_populate_raw_post_data = ${PHP_ALWAYS_POPULATE_RAW_POST_DATA}"'@' /etc/php7/php.ini
  fi
  
  if [ "$PHP_SHORT_OPEN_TAG" -eq "1" ]; then
    sed -i "s/short_open_tag = .*/short_open_tag = On/" /etc/php7/php.ini
  fi

  if [ -n "$PHP_SENDMAIL_PATH" ]; then
    sed -i 's@^;sendmail_path.*@'"sendmail_path = ${PHP_SENDMAIL_PATH}"'@' /etc/php7/php.ini
  fi

  if [ -n "$PHP_SENDMAIL_HOST" -a "$PHP_SENDMAIL_PORT" ]; then
    sed -i 's@^relayhost.*@'"relayhost = [$PHP_SENDMAIL_HOST]:$PHP_SENDMAIL_PORT"'@' /etc/postfix/main.cf
    sed -i 's@^myhostname.*@'"myhostname = $PHP_SENDMAIL_HOST"'@' /etc/postfix/main.cf
    /usr/sbin/postfix -c /etc/postfix start
  fi

  if [ "$CRONTAB_ENABLED" -eq "1" ]; then
    crontab /home/crontasks.txt
    /usr/sbin/crond -L 8
  fi

  if [ "$PHP_XDEBUG_ENABLED" -eq "1" ]; then
    sed -i 's/^;zend_extension.*/zend_extension = xdebug.so/' /etc/php7/conf.d/xdebug.ini
  fi

  if [ -n "$PHP_XDEBUG_PORT" ]; then
    sed -i 's@^xdebug.remote_port.*@'"xdebug\.remote_port = ${PHP_XDEBUG_PORT}"'@' /etc/php7/conf.d/xdebug.ini
  fi

fi

/usr/sbin/php-fpm7 -F
