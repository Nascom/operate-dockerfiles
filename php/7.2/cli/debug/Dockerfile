# Custom PHP 7.2 cli container with xdebug (php:7.2-cli-debug)
FROM nascom/php:7.2-cli

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add xdebug module
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php-xdebug \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV XDEBUG_PORT 9000

COPY xdebug.ini     /etc/php/7.2/cli/conf.d/20-xdebug.ini
COPY run.sh         /run.sh

CMD ["/bin/bash", "/run.sh"]
