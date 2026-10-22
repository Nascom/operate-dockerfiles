#!/bin/bash
set -e
BASE_FOLDER=$(dirname "$(readlink -f "$0")")
#PHP_VERSIONS="8.1 8.2 8.3 8.4"
PHP_VERSIONS="8.4"
DISTRO="bookworm"

# PHP containers
for VERSION in $PHP_VERSIONS; do
    cd $BASE_FOLDER/php/$VERSION/$DISTRO/cli
    echo Building nascom/php:$VERSION-cli
    docker build --pull --no-cache -t nascom/php:$VERSION-cli -t nascom/php:$VERSION-cli-$DISTRO .
    MINOR_VERSION=$(docker run --rm nascom/php:$VERSION-cli php -r 'echo PHP_VERSION;')
    docker tag nascom/php:$VERSION-cli nascom/php:$MINOR_VERSION-cli
    docker tag nascom/php:$VERSION-cli-$DISTRO nascom/php:$MINOR_VERSION-cli-$DISTRO
    docker push nascom/php:$VERSION-cli
    docker push nascom/php:$VERSION-cli-$DISTRO
    docker push nascom/php:$MINOR_VERSION-cli
    docker push nascom/php:$MINOR_VERSION-cli-$DISTRO

    cd $BASE_FOLDER/php/$VERSION/$DISTRO/cli-dev
    echo Building nascom/php:$VERSION-cli-dev
    docker build --no-cache -t nascom/php:$VERSION-cli-dev -t nascom/php:$VERSION-cli-dev-$DISTRO .
    MINOR_VERSION=$(docker run --rm nascom/php:$VERSION-cli-dev php -r 'echo PHP_VERSION;')
    docker tag nascom/php:$VERSION-cli-dev nascom/php:$MINOR_VERSION-cli-dev
    docker tag nascom/php:$VERSION-cli-dev-$DISTRO nascom/php:$MINOR_VERSION-cli-dev-$DISTRO
    docker push nascom/php:$VERSION-cli-dev
    docker push nascom/php:$VERSION-cli-dev-$DISTRO
    docker push nascom/php:$MINOR_VERSION-cli-dev
    docker push nascom/php:$MINOR_VERSION-cli-dev-$DISTRO

    cd $BASE_FOLDER/php/$VERSION/$DISTRO/fpm
    echo Building nascom/php:$VERSION-fpm
    docker build --no-cache -t nascom/php:$VERSION-fpm -t nascom/php:$VERSION-fpm-$DISTRO .
    MINOR_VERSION=$(docker run --rm nascom/php:$VERSION-fpm php -r 'echo PHP_VERSION;')
    docker tag nascom/php:$VERSION-fpm nascom/php:$MINOR_VERSION-fpm
    docker tag nascom/php:$VERSION-fpm-$DISTRO nascom/php:$MINOR_VERSION-fpm-$DISTRO
    docker push nascom/php:$VERSION-fpm
    docker push nascom/php:$VERSION-fpm-$DISTRO
    docker push nascom/php:$MINOR_VERSION-fpm
    docker push nascom/php:$MINOR_VERSION-fpm-$DISTRO
done;
