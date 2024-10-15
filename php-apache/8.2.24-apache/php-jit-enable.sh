#!/bin/bash

echo "zend_extension=opcache
opcache.enable=1
opcache.enable_cli=0
opcache.jit=tracing
opcache.jit_buffer_size=256M" > /usr/local/etc/php/conf.d/config-jit.ini
service apache2 reload
