# PHP-FPM image for LAMP stack
PHP-5 FPM image based on the last Alpine Linux **PHP** packages(**php-5.6.***).

## Main Built features
* Ansible
* Git
* MySQL-Client
* Twig
* PHP-FPM
* PHP-Redis
* Xdebug
* Uploadprogress
* Imagemagick
* Composer
* Drush
* POSIX
* Patch
* TAR
* Wget
* SSH
* Rsync
* Nano

## Include own configs
You could mount to `/temp_configs_dir` with your volume and use own configs. Variable **USE_ONLY_CONFIGS** - disable using the custom variables in the list below.

## How to run

The example command with enabled **Cron**, **Sendmail** and **Xdebug**:

`docker run -v /hostDir:/var/www/localhost/htdocs -d -e CRONTAB_ENABLED="1" -e PHP_FPM_PORT="9000" -e PHP_SENDMAIL_PATH="/usr/sbin/sendmail -i -t" -e PHP_SENDMAIL_HOST="smtp.host" -e PHP_SENDMAIL_PORT="1025" -e PHP_XDEBUG_ENABLED="1" -e PHP_XDEBUG_PORT="9010" -e PHP_MEMORY_LIMIT="1024M" --name php-fpm lordius/alpine-php_fpm:php-5`

## How to access terminal in container
Run a command:

`docker exec -it php-fpm-container-name --user www-data ash`

You will be in folder `/var/www/localhost/htdocs`.

Now, you could run inside container commands like, `composer install`, `php -v` etc.

## Environment Variables

| Variable                          | Default Value | Description |
| --------------------------------- | ------------- | ----------- |
| DRUSH_VERSION                                |   `8.x`                                    | Global Drupal Drush version                                                  |
| PHP_FPM_PORT                                 |   `listen = 8000`                          | Line *`listen`* in the **/etc/php7/php-fpm.conf**                            |
| PHP_MEMORY_LIMIT                             |   `memory_limit = 256M`                    | Line *`memory_limit`* in the **/etc/php7/php.ini**                           |
| PHP_MAX_EXECUTION_TIME                       |   `max_execution_time = 150`               | Line *`max_execution_time`* in the **/etc/php7/php.ini**                     |
| PHP_MAX_FILE_UPLOADS                         |   `max_file_uploads = 20`                  | Line *`max_file_uploads`* in the **/etc/php7/php.ini**                       |
| PHP_MAX_INPUT_NESTING_LEVEL                  |   `;max_input_nesting_level = 64`          | Line *`max_input_nesting_level`* in the **/etc/php7/php.ini**                |
| PHP_MAX_INPUT_TIME                           |   `max_input_time = 60`                    | Line *`max_input_time`* in the **/etc/php7/php.ini**                         |
| PHP_MAX_INPUT_VARS                           |   `; max_input_vars = 1000`                | Line *`max_input_vars`* in the **/etc/php7/php.ini**                         |
| PHP_POST_MAX_SIZE                            |   `post_max_size = 512M`                   | Line *`post_max_size`* in the **/etc/php7/php.ini**                          |
| PHP_UPLOAD_MAX_FILESIZE                      |   `upload_max_filesize = 512M`             | Line *`upload_max_filesize`* in the **/etc/php7/php.ini**                    |
| PHP_ALLOW_URL_FOPEN                          |   `allow_url_fopen = On`                   | Line *`allow_url_fopen`* in the **/etc/php7/php.ini**                        |
| PHP_ALWAYS_POPULATE_RAW_POST_DATA            |   `always_populate_raw_post_data = -1`     | Line *`always_populate_raw_post_data`* in the **/etc/php7/php.ini**          |
| PHP_SENDMAIL_PATH                            |   `sendmail_path = opensmtpd`              | Line *`sendmail_path`* in the **/etc/php7/php.ini**                          |
| PHP_SENDMAIL_HOST                            |   `relayhost = []:`,`myhostname =`         | Lines *`relayhost`*, *`myhostname`* in the **/etc/postfix/main.cf**          |
| PHP_SENDMAIL_PORT                            |   Used as part for `relayhost=host:port`   | Line *`relayhost`* in the **/etc/postfix/main.cf**                           |
| CRONTAB_ENABLED                              |   `0`                                      | Runs commands: `crontab /home/crontasks`, `/usr/sbin/crond -L 8`             |
| PHP_XDEBUG_ENABLED                           |   `0`                                      | Line `zend_extension = xdebug.so` in the **/etc/php7/conf.d/xdebug.ini**     |
| PHP_XDEBUG_PORT                              |   `9000`                                   | Line `xdebug.remote_port` in the **/etc/php7/conf.d/xdebug.ini**             |

## How to use Cron
After enabling option **CRONTAB_ENABLED="1"**, you need to mount file **crontask.txt** in the container file - **/home/crontasks.txt**, e.g:

`docker run -v /hostDir:/var/www/localhost/htdocs -v  crontasks.txt:/home/crontasks.txt -d -e PHP_FPM_PORT="9000" -e CRONTAB_ENABLED="1" --name php-fpm  lordius/alpine-php_fpm:php-5`

## How to use Xdebug
You need to run container with option **PHP_XDEBUG_ENABLED=1** and provide value port for the option **PHP_XDEBUG_PORT**:

`docker run -v /hostDir:/var/www/localhost/htdocs -d -e PHP_FPM_PORT="9000" -e PHP_XDEBUG_ENABLED="1" -e PHP_XDEBUG_PORT="9010" --name php-fpm  lordius/alpine-php_fpm:php-5`

## How to configure with Mail service
You need to listen to **SMTP** service that is linked inside containers:

`docker run -v /hostDir:/var/www/localhost/htdocs -d -e PHP_FPM_PORT="9000" -e PHP_SENDMAIL_PATH="/usr/sbin/sendmail -i -t" -e PHP_SENDMAIL_HOST="smtp.host" -e PHP_SENDMAIL_PORT="1025" --name php-fpm  lordius/alpine-php_fpm:php-5`

## How to use Drush

After run container execute:

`docker exec -it php-fpm-container-name --user www-data /bin/ash`

Inside container go to **PHP** file directory:

` cd /var/www/html/localhost`

You could check work with the command: 

`drush version`

## Full LAMP stack

See [docker-compose-lamp](https://github.com/a-kom/docker-compose-lamp)
