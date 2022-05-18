# Custom PHP 8.0 FPM container
FROM nascom/php:8.0-cli-bullseye

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add fpm module
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        php8.0-fpm \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

WORKDIR /var/www/html

COPY php.ini        /etc/php/8.0/fpm/conf.d/
COPY php-fpm.conf   /etc/php/8.0/fpm/php-fpm.conf

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php-fpm8.0", "--allow-to-run-as-root", "-c /etc/php/8.0/fpm", "--nodaemonize"]
