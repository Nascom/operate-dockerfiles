# Custom PHP 7.0 drush container
FROM nascom/php:7.0-composer

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Install drush
RUN composer global require drush/drush:8.* --prefer-dist

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--", "/run.sh"]
