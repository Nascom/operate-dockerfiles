# Custom PHP 7.3 composer container
FROM nascom/php:7.4-cli-buster

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH

# Hack needed to make sure git clone works?
RUN git config --system user.name Docker && git config --system user.email docker@localhost

# Install composer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
  && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer \
  && rm -rf /tmp/*

# Install drush
RUN composer global require drush/drush:8.* --prefer-dist
