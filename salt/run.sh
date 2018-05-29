#!/bin/bash
if ! (( $(id "$SALT_API_USER" > /dev/null 2>&1) )); then
    /usr/sbin/useradd -ms /bin/false $SALT_API_USER
    echo "$SALT_API_USER:$SALT_API_PASSWORD" | /usr/sbin/chpasswd
fi
/usr/bin/salt-api -c /etc/salt -d
/usr/bin/salt-master -c /etc/salt --log-file-level=quiet --log-level=debug
