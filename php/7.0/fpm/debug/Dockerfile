# Custom PHP 7.0 fpm container with xdebug (php:7.0-fpm-debug)
FROM nascom/php:7.0-fpm-debug

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add xdebug module
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php-xdebug \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# xdebug configuration
RUN echo 'xdebug.remote_port=9000' >> /etc/php/7.0/cli/conf.d/20-xdebug.ini
RUN echo 'xdebug.remote_enable=1' >> /etc/php/7.0/cli/conf.d/20-xdebug.ini
RUN echo 'xdebug.remote_connect_back=1' >> /etc/php/7.0/cli/conf.d/20-xdebug.ini
