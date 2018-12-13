# Custom PHP 5.6 drush container
FROM nascom/php:5.6-composer

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Install Mysql client tools
RUN apt-get update \
    && apt-get install -y mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install drush
RUN composer global require drush/drush:8.* --prefer-dist

COPY docker-php-entrypoint /usr/local/bin/
