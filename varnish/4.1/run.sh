#!/bin/bash
exec varnishd -j unix,user=vcache -F -a :${VARNISH_PORT} -f /etc/varnish/default.vcl -S /etc/varnish/secret -s malloc,${VARNISH_MEMORY} ${VARNISH_DAEMON_OPTS}
