# Custom PHP 8.0 composer container
FROM composer:1 as composer1

FROM composer:2 as composer2

FROM nascom/php:8.0-cli-buster

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH

# Hack needed to make sure git clone works?
RUN git config --system user.name Docker && git config --system user.email docker@localhost

# Install composer
COPY --from=composer1 /usr/bin/composer /usr/bin/composer
COPY --from=composer2 /usr/bin/composer /usr/bin/composer2

# Install drush
RUN composer global require drush/drush:8.* --prefer-dist
