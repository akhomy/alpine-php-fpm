### PHP-FPM
PHP-5 or PHP-7 FPM image based on Alpine Linux. There are Postfix, Crontab, Drush and Xdebug inside.
Configured with Redis, Twig only for PHP-5.

### Include own configs
<p>You could mount to <code>/temp_configs_dir</code> with your volume and use own configs.</p>
<p>USE_ONLY_CONFIGS - disable using of the custom ENV in list bellow.</p>

### Available options
<ul>
<li>PHP_SENDMAIL_PATH - <code>/etc/php7/php.ini sendmail_path</code></li>
<li>CRONTAB_ENABLED - 0/1 enable/disable crontab service</li>
<li>PHP_XDEBUG_ENABLED - 1/0 enable/disable xdebug</li>
<li>PHP_XDEBUG_PORT -  <code>/etc/php7/php.ini xdebug.remote_port </code> where will run in container</li>
<li>PHP_MEMORY_LIMIT - <code>/etc/php7/php.ini memory_limit</code></li>
<li>PHP_MAX_EXECUTION_TIME - <code>/etc/php7/php.ini max_execution_time</code></li>
<li>PHP_MAX_FILE_UPLOADS - <code>/etc/php7/php.ini max_file_uploads</code></li>
<li>PHP_MAX_INPUT_NESTING_LEVEL - <code>/etc/php7/php.ini max_input_nesting_level</code></li>
<li>PHP_MAX_INPUT_TIME - <code>/etc/php7/php.ini max_input_time</code></li>
<li>PHP_MAX_INPUT_VARS - <code>/etc/php7/php.ini max_input_vars</code></li>
<li>PHP_POST_MAX_SIZE - <code>/etc/php7/php.ini post_max_size</code></li>
<li>PHP_UPLOAD_MAX_FILESIZE - <code>/etc/php7/php.ini upload_max_filesize</code></li>
<li>PHP_ALLOW_URL_FOPEN - <code>/etc/php7/php.ini allow_url_fopen</code></li>
<li>PHP_ALWAYS_POPULATE_RAW_POST_DATA - <code>/etc/php7/php.ini always_populate_raw_post_data</code></li>
<li>PHP_SENDMAIL_HOST - <code>/etc/postfix/main.cf sendmail</code> host where we will send mails</li>
<li>PHP_SENDMAIL_PORT - <code>/etc/postfix/main.cf myhostname</code> sendmail host port where smtp host listen</li>
<li>PHP_FPM_PORT  - <code>/etc/php7/php-fpm.conf</code> listen port where container will be listen for connection</li>
</ul>

### How to run

<p>Example of run with enabled cron, sendmail and xdebug:</p>
<code>docker run -v /hostDir:/var/www/localhost/htdocs -d -e CRONTAB_ENABLED="1" -e PHP_FPM_PORT="9000" -e PHP_SENDMAIL_PATH="/usr/sbin/sendmail -i -t" -e PHP_SENDMAIL_HOST="smtp.host" -e PHP_SENDMAIL_PORT="1025" -e PHP_XDEBUG_ENABLED="1" -e PHP_XDEBUG_PORT="9010" -e PHP_MEMORY_LIMIT="1024M" --name php-fpm  lordius/alpine-php_fpm:php-5.6.29</code>


### How to use cron
<p>After enabling CRONTAB_ENABLED="1" option, you need mount crontask.txt file to container file -<code>/home/crontasks.txt</code>, example:</p>
<code>docker run -v /hostDir:/var/www/localhost/htdocs -v  crontasks.txt:/home/crontasks.txt -d -e PHP_FPM_PORT="9000" -e CRONTAB_ENABLED="1" --name php-fpm  lordius/alpine-php_fpm:php-5.6.29</code>

### How to use xdebug
<p>You need run container with PHP_XDEBUG_ENABLED=1 and provide PHP_XDEBUG_PORT port:</p>
<code>docker run -v /hostDir:/var/www/localhost/htdocs -d -e PHP_FPM_PORT="9000" -e PHP_XDEBUG_ENABLED="1" -e PHP_XDEBUG_PORT="9010" --name php-fpm  lordius/alpine-php_fpm:php-5.6.29</code>

### How to configure with mail service
<p>You need listen smtp service that is linked inside containers:</p>
<code>docker run -v /hostDir:/var/www/localhost/htdocs -d -e PHP_FPM_PORT="9000" -e PHP_SENDMAIL_PATH="/usr/sbin/sendmail -i -t" -e PHP_SENDMAIL_HOST="smtp.host" -e PHP_SENDMAIL_PORT="1025" --name php-fpm  lordius/alpine-php_fpm:php-5.6.29</code>

### How to use drush

<p>After run container, please run:</p>
</code>docker exec -it php-fpm-container-name --user www-data /bin/ash<code>
<p>Inside container go to php file dir - <code> cd /var/www/html/localhost</code> </p>
<p>You could check work with run drush.</p>
