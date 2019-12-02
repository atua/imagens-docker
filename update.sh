#!/bin/bash

DIRPHPAPACHE=php-apache

PHPAPACHEIMAGES=(7.3.12-apache 7.4.0-apache)

for PHPAPACHEIMAGE in ${PHPAPACHEIMAGES[@]}
do
  if [ ! -d $DIRPHPAPACHE/$PHPAPACHEIMAGE ]; then
    mkdir $DIRPHPAPACHE/$PHPAPACHEIMAGE
  fi

  cp $DIRPHPAPACHE/Dockerfile $DIRPHPAPACHE/$PHPAPACHEIMAGE
  cp $DIRPHPAPACHE/config.ini $DIRPHPAPACHE/$PHPAPACHEIMAGE
  cp $DIRPHPAPACHE/vhost.conf $DIRPHPAPACHE/$PHPAPACHEIMAGE

  sed -i "1s/<PHPAPACHEIMAGE>/php:${PHPAPACHEIMAGE}/" $DIRPHPAPACHE/$PHPAPACHEIMAGE/Dockerfile
done