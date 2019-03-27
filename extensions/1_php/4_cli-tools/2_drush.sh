#!/bin/bash
composer global require consolidation/cgr;
export PATH="$(composer config -g home)/vendor/bin:$PATH"
export CGR_BIN_DIR=$HOME/bin
cgr drush/drush:"$DRUSH_VERSION";
ln -s $HOME/bin/drush /usr/local/bin/drush;
