#!/bin/bash

# If the build does not work, you will probably have to add a Docker multiarch builder first.
# See the README.md at the root of the repo...

docker buildx build --platform=linux/amd64,linux/arm64 -t nascom/elasticsearch:6 --push .
