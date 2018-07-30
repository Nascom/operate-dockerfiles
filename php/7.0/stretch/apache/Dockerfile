# Custom PHP 7.0 apache container (DEPRECATED - use fpm instead)
FROM nascom/php:7.0-base

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Set www-data uid & gid
RUN usermod -u 3000 www-data && \
    groupmod -g 3000 www-data

# Add apache support
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        apache2 \
        libapache2-mod-php7.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable apache modules
RUN a2enmod proxy \
    && a2enmod proxy_http \
    && a2enmod proxy_fcgi \
    && a2enmod authn_core \
    && a2enmod access_compat \
    && a2enmod alias \
    && a2enmod authz_core \
    && a2enmod authz_host \
    && a2enmod authz_user \
    && a2enmod dir \
    && a2enmod env \
    && a2enmod mime \
    && a2enmod reqtimeout \
    && a2enmod rewrite \
    && a2enmod status \
    && a2enmod filter \
    && a2enmod deflate \
    && a2enmod setenvif \
    && a2enmod vhost_alias \
    && a2enmod ssl \
    && a2enmod remoteip

EXPOSE 80
EXPOSE 443

ENV DOCUMENT_ROOT /var/www/html
ENV ENVIRONMENT dev
ENV PHP_ERROR_REPORTING "E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED"

# Enable libsodium
RUN phpenmod libsodium

COPY mail.ini       /etc/php/7.0/apache2/conf.d/
COPY php.ini        /etc/php/7.0/apache2/conf.d/
COPY run.sh         /run.sh

CMD ["/bin/bash", "/run.sh"]
