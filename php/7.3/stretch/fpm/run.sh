#!/bin/bash

variables=( "PHP_FPM_PORT" "PHP_ERROR_REPORTING" "PHP_FPM_MAX_CHILDREN" "ENVIRONMENT" )

for var in "${variables[@]}"
do
   :
   sed -i "s|%$var%|${!var}|g" /etc/php/7.3/fpm/php-fpm.conf
done

if [ ! -z $PHP_FPM_GID ]; then
    groupmod -g $PHP_FPM_GID www-data
fi

if [ ! -z $PHP_FPM_UID ]; then
    usermod -u $PHP_FPM_UID www-data
fi

mkdir -p /run/php
/usr/sbin/php-fpm7.3 --allow-to-run-as-root -c /etc/php/7.3/fpm --nodaemonize
