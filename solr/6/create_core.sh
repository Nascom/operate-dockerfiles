#!/bin/bash
CORE=$1
/usr/local/solr/bin/solr create_core -c $CORE
