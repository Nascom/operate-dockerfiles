#!/bin/bash

variables=( "PHP_FPM_USER" "PHP_FPM_PORT" "PHP_ERROR_REPORTING" "ENVIRONMENT" )

for var in "${variables[@]}"
do
   :
   sed -i "s|%$var%|${!var}|g" /etc/php/7.1/fpm/php-fpm.conf
done
sed -i "s|%SMTP_SERVER%|$SMTP_SERVER|g" /etc/ssmtp/ssmtp.conf
sed -i "s|%ROOT_EMAIL%|$ROOT_EMAIL|g" /etc/ssmtp/ssmtp.conf

if id "$PHP_FPM_USER" >/dev/null 2>&1; then
    # User exists, change UID
    usermod -u $PHP_FPM_UID $PHP_FPM_USER
else
    # User does not exist, create it
    useradd -u $PHP_FPM_UID -r -m -s /bin/bash -c "FPM user" $PHP_FPM_USER
fi

mkdir -p /run/php
/usr/sbin/php-fpm7.1 --allow-to-run-as-root -c /etc/php/7.1/fpm --nodaemonize
