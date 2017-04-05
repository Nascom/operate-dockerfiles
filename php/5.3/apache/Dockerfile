# Custom PHP 5.3 apache container for old legacy projects
# NEVER use this for new projects!!
FROM nascom/php:5.3-base

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

RUN usermod -u 3000 www-data && \
    groupmod -g 3000 www-data

# Add apache packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        apache2 \
        libapache2-mod-php5 \
    && apt-get remove -y --purge build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
EXPOSE 443

ENV ENVIRONMENT dev
ENV PHP_ERROR_REPORTING "E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED"
ENV SMTP_SERVER mail.nascom.be
ENV ROOT_EMAIL admin@nascom.be

COPY mail.ini   /etc/php5/apache2/conf.d/
COPY php.ini    /etc/php5/apache2/conf.d/
COPY run.sh     /run.sh

CMD ["/bin/bash", "/run.sh"]
