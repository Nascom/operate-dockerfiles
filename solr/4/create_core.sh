#!/bin/bash
CORE=$1
cd $SOLR_HOME
cp -Rp core0 $CORE
sed -i "s|name=core0|name=$CORE|g" $SOLR_HOME/$CORE/core.properties
