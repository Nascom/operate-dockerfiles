FROM nascom/php:7.3-cli-alpine

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH

# Hack needed to make sure git clone works?
RUN apk add --no-cache git openssh-client patch \
  && git config --system user.name Docker && git config --system user.email docker@localhost

# Install composer
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer2

# Install drush
RUN composer global require drush/drush:8.* --prefer-dist

# Install symfony CLI
RUN apk add --no-cache bash \
    && wget https://get.symfony.com/cli/installer -O - | bash \
    && mv /root/.symfony/bin/symfony /usr/local/bin/symfony \
    && rm -rf /root/.symfony \
    && apk del --no-cache bash
