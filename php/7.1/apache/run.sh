#!/bin/bash

rm -f /var/run/apache2/apache2.pid
sed -i "s|DOCUMENT_ROOT|$DOCUMENT_ROOT|g" /etc/apache2/sites-available/000-default.conf
sed -i "s|ENVIRONMENT_VAR|$ENVIRONMENT|g" /etc/apache2/sites-available/000-default.conf
sed -i "s|PHP_ERROR_REPORTING_VAR|$PHP_ERROR_REPORTING|g" /etc/php/7.1/apache2/conf.d/php.ini
sed -i "s|PHP_ERROR_REPORTING_VAR|$PHP_ERROR_REPORTING|g" /etc/php/7.1/cli/conf.d/php.ini
sed -i "s|%SMTP_SERVER%|$SMTP_SERVER|g" /etc/ssmtp/ssmtp.conf
sed -i "s|%ROOT_EMAIL%|$ROOT_EMAIL|g" /etc/ssmtp/ssmtp.conf
/usr/sbin/apache2ctl -D FOREGROUND
