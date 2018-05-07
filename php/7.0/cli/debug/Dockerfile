# Custom PHP 7.0 cli container with xdebug (php:7.0-cli-debug)
FROM nascom/php:7.0-cli

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add xdebug module
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php-xdebug \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
