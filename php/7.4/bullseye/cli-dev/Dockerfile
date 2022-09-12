# Custom PHP 7.4 composer container
FROM composer:1 as composer1

FROM composer:2 as composer2

FROM nascom/php:7.4-cli-bullseye

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        git \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Hack needed to make sure git clone works?
RUN git config --system user.name Docker && git config --system user.email docker@localhost

# Install composer - make composer 2 the default but keep composer1 for legacy
COPY --from=composer1 /usr/bin/composer /usr/bin/composer1
COPY --from=composer2 /usr/bin/composer /usr/bin/composer

RUN ln -s /usr/bin/composer /usr/bin/composer2

# Install drush
RUN composer global require drush/drush:8.* --prefer-dist

# Install symfony CLI
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash \
    && apt install symfony-cli \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
