#!/bin/bash

variables=( "PHP_FPM_PORT" "PHP_ERROR_REPORTING" "PHP_FPM_MAX_CHILDREN" "ENVIRONMENT" )

for var in "${variables[@]}"
do
   :
   sed -i "s|%$var%|${!var}|g" /etc/php/5.6/fpm/php-fpm.conf
done
sed -i "s|%SMTP_SERVER%|$SMTP_SERVER|g" /etc/ssmtp/ssmtp.conf
sed -i "s|%ROOT_EMAIL%|$ROOT_EMAIL|g" /etc/ssmtp/ssmtp.conf

# xdebug configuration
echo "xdebug.remote_port=$XDEBUG_PORT" >> /etc/php/5.6/cli/conf.d/20-xdebug.ini
echo "xdebug.remote_enable=1" >> /etc/php/5.6/cli/conf.d/20-xdebug.ini
echo "xdebug.remote_connect_back=1" >> /etc/php/5.6/cli/conf.d/20-xdebug.ini

if [ ! -z $PHP_FPM_GID ]; then
    groupmod -g $PHP_FPM_GID www-data
fi

if [ ! -z $PHP_FPM_UID ]; then
    usermod -u $PHP_FPM_UID www-data
fi

sed -i "s|%XDEBUG_PORT%|$XDEBUG_PORT|g" /etc/php/5.6/cli/conf.d/20-xdebug.ini
sed -i "s|%XDEBUG_PORT%|$XDEBUG_PORT|g" /etc/php/5.6/fpm/conf.d/20-xdebug.ini

/usr/sbin/php-fpm5.6 --allow-to-run-as-root -c /etc/php/5.6/fpm --nodaemonize
