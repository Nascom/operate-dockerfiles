# Custom PHP 7.4 FPM container
FROM nascom/php:7.4-cli-bullseye

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add fpm module
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php7.4-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

WORKDIR /var/www/html

COPY php.ini        /etc/php/7.4/fpm/conf.d/
COPY php-fpm.conf   /etc/php/7.4/fpm/php-fpm.conf

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php-fpm7.4", "--allow-to-run-as-root", "-c /etc/php/7.4/fpm", "--nodaemonize"]
