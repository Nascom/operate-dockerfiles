# Custom PHP-CLI & FPM container for old legacy projects
#
# NEVER use this for new projects!!
FROM ubuntu:12.04

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

# Install basic utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        wget \
        locales \
        git \
        zip \
        unzip \
        ssmtp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo Europe/Brussels > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN locale-gen cs_CZ cs_CZ.UTF-8 \
    && locale-gen da_DK da_DK.UTF-8 \
    && locale-gen de_AT de_AT.UTF-8 \
    && locale-gen de_CH de_CH.UTF-8 \
    && locale-gen de_DE de_DE.UTF-8 \
    && locale-gen en_CA en_CA.UTF-8 \
    && locale-gen en_GB en_GB.UTF-8 \
    && locale-gen en_IE en_IE.UTF-8 \
    && locale-gen en_US en_US.UTF-8 \
    && locale-gen en_ZA en_ZA.UTF-8 \
    && locale-gen es_ES es_ES.UTF-8 \
    && locale-gen fa_IR \
    && locale-gen fr_BE fr_BE@euro fr_BE.UTF-8 \
    && locale-gen fr_CA fr_CA.UTF-8 \
    && locale-gen fr_CH fr_CH.UTF-8 \
    && locale-gen fr_FR fr_FR@euro fr_FR.UTF-8 \
    && locale-gen it_CH it_CH.UTF-8 \
    && locale-gen it_IT it_IT.UTF-8 \
    && locale-gen nl_BE nl_BE@euro nl_BE.UTF-8 \
    && locale-gen nl_NL nl_NL@euro nl_NL.UTF-8 \
    && locale-gen pl_PL pl_PL.UTF-8 \
    && locale-gen pt_PT pt_PT.UTF-8 \
    && locale-gen ro_RO ro_RO.UTF-8 \
    && locale-gen ru_RU ru_RU.UTF-8 \
    && locale-gen sv_SE sv_SE.UTF-8 \
    && locale-gen tr_TR tr_TR.UTF-8 \
    && locale-gen uk_UA uk_UA.UTF-8 \
    && locale-gen zh_CN zh_CN.UTF-8

RUN usermod -u 3000 www-data && \
    groupmod -g 3000 www-data

# Add all PHP modules we need & cleanup
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        php-apc \
        php5-cli \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-imagick \
        php5-imap \
        php5-intl \
        php5-json \
        php5-mcrypt \
        php5-memcached \
        php5-mysql \
        php-pear \
        php-soap \
        php5-tidy \
    && pecl install uploadprogress \
    && apt-get remove -y --purge build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

ENV ENVIRONMENT dev
ENV PHP_FPM_USER www-data
ENV PHP_FPM_PORT 9000
ENV PHP_ERROR_REPORTING "E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED"
ENV SMTP_SERVER mail.nascom.be
ENV ROOT_EMAIL admin@nascom.be

COPY mail.ini   /etc/php5/fpm/conf.d/
COPY php.ini    /etc/php5/fpm/conf.d/
COPY mail.ini   /etc/php5/cli/conf.d/
COPY php.ini    /etc/php5/cli/conf.d/
COPY www.conf   /etc/php5/fpm/pool.d/
COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY run.sh     /run.sh

CMD ["/bin/bash", "/run.sh"]
