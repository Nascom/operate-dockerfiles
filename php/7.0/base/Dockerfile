# Custom PHP 7.0 base container (used as basis for all other PHP containers)
FROM debian:stretch

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
        xz-utils \
        gnupg \
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

# Add all PHP modules we need & cleanup
RUN wget -O- https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php-packages.sury.org.list \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php7.0-apcu \
        php7.0-bcmath \
        php7.0-bz2 \
        php7.0-cli \
        php7.0-curl \
        php7.0-gd \
        php7.0-imagick \
        php7.0-imap \
        php7.0-intl \
        php7.0-json \
        php7.0-mcrypt \
        php7.0-mbstring \
        php7.0-memcached \
        php7.0-mysql \
        php7.0-mysqlnd \
        php7.0-soap \
        php7.0-tidy \
        php7.0-xml \
        php7.0-xmlrpc \
        php7.0-zip \
        php7.0-dev \
        php-pear \
        libsodium-dev \
    && pecl install libsodium \
    && apt-get remove --purge php7.0-dev php-pear -y \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add wkhtmltopdf
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libxrender1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && wget -O /tmp/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz https://downloads.wkhtmltopdf.org/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar -C /usr/local -xf /tmp/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && ln -s /usr/local/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf \
    && ln -s /usr/local/wkhtmltox/bin/wkhtmltoimage /usr/local/bin/wkhtmltoimage \
    && rm -rf /tmp/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

ENV SMTP_SERVER mail
ENV ROOT_EMAIL admin@nascom.be

COPY libsodium.ini  /etc/php/7.0/mods-available/libsodium.ini
COPY mail.ini       /etc/php/7.0/cli/conf.d/
COPY php.ini        /etc/php/7.0/cli/conf.d/
COPY ssmtp.conf     /etc/ssmtp/ssmtp.conf
# Quickfix to make sure users can run container with custom config
RUN  chmod a+w      /etc/ssmtp
RUN  chmod a+w      /etc/ssmtp/ssmtp.conf
