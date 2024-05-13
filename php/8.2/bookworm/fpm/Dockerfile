# Custom PHP 8.2 FPM container
FROM nascom/php:8.2-cli-bookworm

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add fpm module
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        php8.2-fpm \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

WORKDIR /var/www/html

COPY php.ini        /etc/php/8.2/fpm/conf.d/
COPY php-fpm.conf   /etc/php/8.2/fpm/php-fpm.conf

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php-fpm8.2", "--allow-to-run-as-root", "-c /etc/php/8.2/fpm", "--nodaemonize"]
