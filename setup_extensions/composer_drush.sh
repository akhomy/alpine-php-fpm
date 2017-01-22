#!/bin/bash
cd /temp_docker
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer

cd /temp_docker
git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
cd /usr/local/src/drush
git checkout $1  #or whatever version you want. for example master
ln -s /usr/local/src/drush/drush /usr/bin/drush
composer install
drush --version
