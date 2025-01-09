#!/bin/bash

rm -f /usr/local/etc/php/conf.d/config-jit.ini
service apache2 reload
