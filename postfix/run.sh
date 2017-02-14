#!/bin/bash
#touch /var/log/mail.log
rsyslogd
echo Syslog started
postfix start
echo Postfix started
tail -n0 -F /var/log/mail.log
