#!/bin/bash
set -e

trap 'echo "Shutting down..."; exit 0' SIGINT

# Setup default multicore config if needed ...
if [ ! -f $SOLR_HOME/solr.xml ]; then
    cp /config/solr.xml $SOLR_HOME
fi
if [ ! -d $SOLR_HOME/core0 ]; then
    cp -R /config/core0 $SOLR_HOME/core0
fi

if [ -z "$1" ]; then
  exec /usr/local/solr/bin/solr start -f
elif [[ "${1:0:1}" == '-' ]]; then
  exec /usr/local/solr/bin/solr start -f "$@"
  for ((i=10;i--;i>0)); do
    LOG="$(find /usr/local/solr -name "solr.log" -mtime -1)"
    if [ -n "$LOG" ]; then
      tail -f $LOG
    else
      echo "waiting for log for example \"$2\" to become available.."
      echo "${i} seconds remaining.."
    fi
    sleep 1
  done
else
  exec "$@"
fi

echo "Done"
