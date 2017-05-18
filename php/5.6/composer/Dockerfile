# Custom PHP 5.6 composer container
# Should NOT be used for new projects unless it's required by the hosting provider
FROM nascom/php:5.6-cli

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
  && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer \
  && rm -rf /tmp/*

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--", "/run.sh"]
