#!/bin/bash
composer global require consolidation/cgr;
export PATH="$(composer config -g home)/vendor/bin:$PATH"
export CGR_BIN_DIR=$HOME/bin
COMPOSER_HOME=/opt/drush COMPOSER_BIN_DIR=/usr/local/bin COMPOSER_VENDOR_DIR=/opt/drush/"$DRUSH_VERSION" composer require drush/drush:^"$DRUSH_VERSION"
chmod +x /opt
