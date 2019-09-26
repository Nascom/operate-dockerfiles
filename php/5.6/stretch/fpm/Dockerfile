# Custom PHP 5.6 FPM container
# Should NOT be used for new projects unless it's required by the hosting provider
FROM nascom/php:5.6-base

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add all PHP modules we need & cleanup
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php5.6-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

ENV ENVIRONMENT dev
ENV PHP_FPM_UID 33
ENV PHP_FPM_GID 33
ENV PHP_FPM_PORT 9000
ENV PHP_FPM_MAX_CHILDREN 5
ENV PHP_ERROR_REPORTING "E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED"

WORKDIR /var/www/html

# Enable libsodium
RUN phpenmod libsodium

COPY mail.ini       /etc/php/5.6/fpm/conf.d/
COPY php.ini        /etc/php/5.6/fpm/conf.d/
COPY php-fpm.conf   /etc/php/5.6/fpm/php-fpm.conf
COPY run.sh         /run.sh

CMD ["/bin/bash", "/run.sh"]
