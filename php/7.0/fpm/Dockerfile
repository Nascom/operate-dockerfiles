# Custom PHP 7.0 FPM container
FROM nascom/php:7.0-base

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

# Set www-data uid & gid
RUN usermod -u 3000 www-data && \
    groupmod -g 3000 www-data

# Add fpm module
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php7.0-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

ENV ENVIRONMENT dev
ENV PHP_FPM_USER www-data
ENV PHP_FPM_PORT 9000
ENV PHP_ERROR_REPORTING "E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED"
ENV SMTP_SERVER mail.nascom.be
ENV ROOT_EMAIL admin@nascom.be

COPY mail.ini   /etc/php/7.0/fpm/conf.d/
COPY php.ini    /etc/php/7.0/fpm/conf.d/
COPY www.conf   /etc/php/7.0/fpm/pool.d/
COPY run.sh     /run.sh

CMD ["/bin/bash", "/run.sh"]
