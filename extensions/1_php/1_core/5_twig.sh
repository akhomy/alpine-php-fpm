#!/bin/bash
cd /temp_docker && wget https://github.com/twigphp/Twig/archive/$TWIG_VERSION.tar.gz
cd /temp_docker && tar -xvzf $TWIG_VERSION.tar.gz
cd /temp_docker && cd $TWIG_PATH/ext/twig && phpize
cd /temp_docker && cd $TWIG_PATH/ext/twig && ./configure
cd /temp_docker && cd $TWIG_PATH/ext/twig && make
cd /temp_docker && cd $TWIG_PATH/ext/twig && make test
cp /temp_docker/$TWIG_PATH/ext/twig/modules/twig.so /usr/lib/php5/modules/twig.so && \
    echo 'extension=twig.so' > /etc/php5/conf.d/twig.ini
