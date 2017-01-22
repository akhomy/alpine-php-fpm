### Php5-fpm
Php5 fpm image based on Alpine linux. There are postfix, crontab, drush and xdebug inside.
Configured with redis, twig.

### Available options
CRONTAB_ENABLED - 0/1 enable/disable crontab service
PHP_FPM_PORT  - port where container will be listen for connection
PHP_SENDMAIL_PATH - senmail path
PHP_SENDMAIL_HOST - sendmail host where we will send mails
PHP_SENDMAIL_PORT - sendmail host port where smtp host listen
PHP_MEMORY_LIMIT - php memory limit
PHP_MAX_EXECUTION_TIME  - max php execution time
PHP_POST_MAX_SIZE   - max size of post request
PHP_UPLOAD_MAX_FILESIZE  - max size of uploaded file
PHP_ALLOW_URL_FOPEN  - php option allow_url_fopen
PHP_ALWAYS_POPULATE_RAW_POST_DATA   - php option always_populate_raw_post_data
PHP_XDEBUG_ENABLED   - 1/0 enable/disable xdebug
PHP_XDEBUG_PORT   - port where xdebug will run in container

### How to run

Example of run with enabled cron, sendmail and xdebug:
docker run -v /hostDir:/var/www/localhost/htdocs -d -e CRONTAB_ENABLED="1" -e PHP_FPM_PORT="9000" -e PHP_SENDMAIL_PATH="/usr/sbin/sendmail -i -t" -e PHP_SENDMAIL_HOST="smtp.host" -e PHP_SENDMAIL_PORT="1025" -e PHP_XDEBUG_ENABLED="1" -e PHP_XDEBUG_PORT="9010" -e PHP_MEMORY_LIMIT="1024M" --name php-fpm  lordius/alpine-php_fpm:php-5.6.29


### How to use cron
After enable CRONTAB_ENABLED="1" option you need mount crontask.txt file to container file - /home/crontasks.txt, example:
docker run -v /hostDir:/var/www/localhost/htdocs -v  crontasks.txt:/home/crontasks.txt -d -e PHP_FPM_PORT="9000" -e CRONTAB_ENABLED="1" --name php-fpm  lordius/alpine-php_fpm:php-5.6.29

### How to use xdebug
You need run container with PHP_XDEBUG_ENABLED=1 and provide PHP_XDEBUG_PORT port:
docker run -v /hostDir:/var/www/localhost/htdocs -d -e PHP_FPM_PORT="9000" -e PHP_XDEBUG_ENABLED="1" -e PHP_XDEBUG_PORT="9010" --name php-fpm  lordius/alpine-php_fpm:php-5.6.29

### How to configure with mail service
You need listen smtp service that is linked inside containers:
docker run -v /hostDir:/var/www/localhost/htdocs -d -e PHP_FPM_PORT="9000" -e PHP_SENDMAIL_PATH="/usr/sbin/sendmail -i -t" -e PHP_SENDMAIL_HOST="smtp.host" -e PHP_SENDMAIL_PORT="1025" --name php-fpm  lordius/alpine-php_fpm:php-5.6.29

### How to use drush

After run container, please run:
docker exec -it php-fpm-container-name /bin/ash
Inside container go to php file dir - cd /var/www/html/localhost 
And run drush