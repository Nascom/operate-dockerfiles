#!/bin/bash
sed -i "s|%SMTP_SERVER%|$SMTP_SERVER|g" /etc/ssmtp/ssmtp.conf
sed -i "s|%ROOT_EMAIL%|$ROOT_EMAIL|g" /etc/ssmtp/ssmtp.conf

sed -i "s|%XDEBUG_PORT%|$XDEBUG_PORT|g" /etc/php/7.0/cli/conf.d/20-xdebug.ini

/usr/bin/php "$@"
