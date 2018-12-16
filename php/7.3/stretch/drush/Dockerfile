# Custom PHP 7.3 drush container
FROM nascom/php:7.3-composer

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Install Mysql client tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install drush
RUN composer global require drush/drush:8.* --prefer-dist

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--", "/run.sh"]
