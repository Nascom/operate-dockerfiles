# Custom PHP-CLI & FPM container
FROM debian:jessie

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

# Install most recent version of basic utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        wget \
        locales \
        git \
        zip \
        unzip \
        ssmtp \
        apt-transport-https \
        ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Brussels /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Generate locales
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

# Set www-data uid & gid
RUN usermod -u 3000 www-data && \
    groupmod -g 3000 www-data

# Add all PHP modules we need & cleanup
RUN wget -O- https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php-packages.sury.org.list \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        apache2 \
        libapache2-mod-php7.1 \
        php7.1-bcmath \
        php7.1-bz2 \
        php7.1-cli \
        php7.1-curl \
        php7.1-gd \
        php7.1-imagick \
        php7.1-imap \
        php7.1-intl \
        php7.1-json \
        php7.1-mcrypt \
        php7.1-mbstring \
        php7.1-memcached \
        php7.1-mysql \
        php7.1-mysqlnd \
        php7.1-opcache \
        php7.1-soap \
        php7.1-tidy \
        php7.1-xml \
        php7.1-xmlrpc \
        php7.1-zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enabale apache modules
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
    && a2enmod ssl

EXPOSE 80
EXPOSE 443

ENV DOCUMENT_ROOT /var/www/html
ENV ENVIRONMENT dev
ENV PHP_ERROR_REPORTING "E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED"
ENV SMTP_SERVER mail.nascom.be
ENV ROOT_EMAIL admin@nascom.be

COPY default.conf   /etc/apache2/sites-available/000-default.conf
COPY mail.ini       /etc/php/7.1/apache2/conf.d/
COPY php.ini        /etc/php/7.1/apache2/conf.d/
COPY mail.ini       /etc/php/7.1/cli/conf.d/
COPY php.ini        /etc/php/7.1/cli/conf.d/
COPY ssmtp.conf     /etc/ssmtp/ssmtp.conf
COPY run.sh         /run.sh

CMD ["/bin/bash", "/run.sh"]
