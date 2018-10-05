#!/bin/bash
cd /temp_docker
wget https://getcomposer.org/installer && php installer
mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer

composer global require drush/drush:8.*
