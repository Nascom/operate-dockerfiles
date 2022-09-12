# Custom PHP 8.1 cli-dev container
FROM composer:2 as composer

FROM nascom/php:8.1-cli-bullseye

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

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install drush
RUN composer global require drush/drush:8.* --prefer-dist

# Install symfony CLI
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash \
    && apt install symfony-cli \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
