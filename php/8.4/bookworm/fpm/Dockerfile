# Custom PHP 8.4 FPM container
FROM nascom/php:8.4-cli-bookworm

LABEL maintainer="Christopher Bielen <christopher.bielen@dynamate.be>"

# Add fpm module
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        php8.4-fpm \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

WORKDIR /var/www/html

COPY php.ini        /etc/php/8.4/fpm/conf.d/
COPY php-fpm.conf   /etc/php/8.4/fpm/php-fpm.conf

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php-fpm8.4", "--allow-to-run-as-root", "-c /etc/php/8.4/fpm", "--nodaemonize"]
