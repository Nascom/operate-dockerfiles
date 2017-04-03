#!/bin/bash
FILES="localtime services resolv.conf hosts nsswitch.conf nss_mdns.config"
for file in $FILES; do
    cp /etc/${file} /var/spool/postfix/etc/${file}
    chmod a+rX /var/spool/postfix/etc/${file}
done
rsyslogd
echo Syslog started
postfix start
echo Postfix started
tail -n0 -F /var/log/mail.log
