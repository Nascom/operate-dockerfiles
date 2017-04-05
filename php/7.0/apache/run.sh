#!/bin/bash

rm -f /var/run/apache2/apache2.pid
sed -i "s|PHP_ERROR_REPORTING_VAR|$PHP_ERROR_REPORTING|g" /etc/php/7.0/apache2/conf.d/php.ini
sed -i "s|PHP_ERROR_REPORTING_VAR|$PHP_ERROR_REPORTING|g" /etc/php/7.0/cli/conf.d/php.ini
sed -i "s|%SMTP_SERVER%|$SMTP_SERVER|g" /etc/ssmtp/ssmtp.conf
sed -i "s|%ROOT_EMAIL%|$ROOT_EMAIL|g" /etc/ssmtp/ssmtp.conf
/usr/sbin/apache2ctl -D FOREGROUND
