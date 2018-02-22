# Custom PHP 7.2 FPM container *EXPERIMENTAL : DO NOT USE IN PRODUCTION!*
FROM nascom/php:7.2-base

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add fpm module
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php7.2-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

ENV ENVIRONMENT dev
ENV PHP_FPM_UID 33
ENV PHP_FPM_GID 33
ENV PHP_FPM_PORT 9000
ENV PHP_ERROR_REPORTING "E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED"

COPY mail.ini       /etc/php/7.2/fpm/conf.d/
COPY php.ini        /etc/php/7.2/fpm/conf.d/
COPY php-fpm.conf   /etc/php/7.2/fpm/php-fpm.conf
COPY run.sh         /run.sh

CMD ["/bin/bash", "/run.sh"]
