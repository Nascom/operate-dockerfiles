# Custom PHP FPM container
FROM nascom/php:5.3-base

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

# Add fpm module
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php5-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

ENV ENVIRONMENT dev
ENV PHP_FPM_USER www-data
ENV PHP_FPM_UID 33
ENV PHP_FPM_PORT 9000
ENV PHP_ERROR_REPORTING "E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED"

COPY mail.ini       /etc/php5/fpm/conf.d/
COPY php.ini        /etc/php5/fpm/conf.d/
COPY php-fpm.conf   /etc/php5/fpm/php-fpm.conf
COPY run.sh         /run.sh

CMD ["/bin/bash", "/run.sh"]
