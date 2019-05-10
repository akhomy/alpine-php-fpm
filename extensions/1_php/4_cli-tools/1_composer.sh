#!/bin/bash
cd /temp_docker
wget https://getcomposer.org/installer && php installer
mv composer.phar /usr/local/bin/composer
export PATH="$(composer config -g home)/vendor/bin:$PATH"
