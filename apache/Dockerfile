FROM debian:buster-slim

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Add apache support
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        apache2 \
        brotli \
    && a2enmod proxy \
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
    && a2enmod remoteip \
    && a2enmod headers \
    && a2enmod expires \
    && a2enmod brotli \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY apache2.conf /etc/apache2/apache2.conf
COPY run.sh       /run.sh

EXPOSE 80
EXPOSE 443

CMD ["/bin/bash", "/run.sh"]
