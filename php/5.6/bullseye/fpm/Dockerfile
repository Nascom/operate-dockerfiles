# Custom PHP 5.6 FPM container
FROM nascom/php:5.6-cli-bullseye

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add fpm module
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php5.6-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

WORKDIR /var/www/html

COPY php.ini        /etc/php/5.6/fpm/conf.d/
COPY php-fpm.conf   /etc/php/5.6/fpm/php-fpm.conf

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php-fpm5.6", "--allow-to-run-as-root", "-c /etc/php/5.6/fpm", "--nodaemonize"]
