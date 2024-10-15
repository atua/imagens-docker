#!/bin/bash

echo "error_reporting=E_ALL & ~E_NOTICE" > /usr/local/etc/php/conf.d/config-errors.ini
service apache2 reload
