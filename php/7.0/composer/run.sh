#!/bin/bash
set -e

trap 'echo "Shutting down..."; exit 0' SIGINT
exec "$@"
