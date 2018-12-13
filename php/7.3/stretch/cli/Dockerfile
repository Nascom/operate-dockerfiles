# Custom PHP 7.3 cli container
FROM php:7.3-cli-stretch

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

RUN apt-get update \
    && apt-get install -y \
        curl \
        locales \
        git \
        zip \
        unzip \
        ssmtp \
        apt-transport-https \
        ca-certificates \
        xz-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Brussels /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Generate locales
RUN echo 'cs_CZ ISO-8859-2\n\
cs_CZ.UTF-8 UTF-8\n\
da_DK ISO-8859-1\n\
da_DK.UTF-8 UTF-8\n\
de_AT ISO-8859-1\n\
de_AT.UTF-8 UTF-8\n\
de_CH ISO-8859-1\n\
de_CH.UTF-8 UTF-8\n\
de_DE ISO-8859-1\n\
de_DE.UTF-8 UTF-8\n\
en_CA ISO-8859-1\n\
en_CA.UTF-8 UTF-8\n\
en_GB ISO-8859-1\n\
en_GB.UTF-8 UTF-8\n\
en_IE ISO-8859-1\n\
en_IE.UTF-8 UTF-8\n\
en_US ISO-8859-1\n\
en_US.UTF-8 UTF-8\n\
en_ZA ISO-8859-1\n\
en_ZA.UTF-8 UTF-8\n\
es_ES ISO-8859-1\n\
es_ES.UTF-8 UTF-8\n\
fa_IR UTF-8\n\
fr_BE ISO-8859-1\n\
fr_BE@euro ISO-8859-15\n\
fr_BE.UTF-8 UTF-8\n\
fr_CA ISO-8859-1\n\
fr_CA.UTF-8 UTF-8\n\
fr_CH ISO-8859-1\n\
fr_CH.UTF-8 UTF-8\n\
fr_FR ISO-8859-1\n\
fr_FR@euro ISO-8859-15\n\
fr_FR.UTF-8 UTF-8\n\
it_CH ISO-8859-1\n\
it_CH.UTF-8 UTF-8\n\
it_IT ISO-8859-1\n\
it_IT.UTF-8 UTF-8\n\
nl_BE ISO-8859-1\n\
nl_BE@euro ISO-8859-15\n\
nl_BE.UTF-8 UTF-8\n\
nl_NL ISO-8859-1\n\
nl_NL@euro ISO-8859-15\n\
nl_NL.UTF-8 UTF-8\n\
pl_PL ISO-8859-2\n\
pl_PL.UTF-8 UTF-8\n\
pt_PT ISO-8859-1\n\
pt_PT.UTF-8 UTF-8\n\
ro_RO ISO-8859-2\n\
ro_RO.UTF-8 UTF-8\n\
ru_RU ISO-8859-5\n\
ru_RU.UTF-8 UTF-8\n\
sv_SE ISO-8859-1\n\
sv_SE.UTF-8 UTF-8\n\
tr_TR ISO-8859-9\n\
tr_TR.UTF-8 UTF-8\n\
uk_UA.UTF-8 UTF-8\n\
zh_CN.UTF-8 UTF-8\n' >> /etc/locale.gen \
  && locale-gen

RUN docker-php-ext-enable opcache

# bcmath extension
RUN docker-php-ext-install -j$(nproc) bcmath

# calendar extension
RUN docker-php-ext-install -j$(nproc) calendar

# gettext extension
RUN docker-php-ext-install -j$(nproc) gettext

# exif extension
RUN docker-php-ext-install -j$(nproc) exif

# iconv extension
RUN docker-php-ext-install -j$(nproc) iconv

RUN apt-get update \
    && apt-get install -y imagemagick libmagickwand-dev \
    && pecl install -f imagick \
    && docker-php-ext-enable imagick \
    && apt-get remove -y --purge libmagickwand-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# mysqli (legacy)
RUN docker-php-ext-install -j$(nproc) mysqli

# PDO extension (with mysql & postgresql support)
RUN apt-get update \
    && apt-get install -y libpq5 libpq-dev \
    && docker-php-ext-install -j$(nproc) pdo pdo_mysql pdo_pgsql \
    && apt-get remove -y --purge libpq-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# sockets extension
RUN docker-php-ext-install -j$(nproc) sockets

# BZip2 extension
RUN apt-get update \
    && apt-get install -y libbz2-dev \
    && docker-php-ext-install -j$(nproc) bz2 \
    && apt-get remove -y --purge libbz2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# gd extension
RUN apt-get update \
    && apt-get install -y \
        libjpeg62-turbo \
        libjpeg62-turbo-dev \
        libpng16-16 \
        libpng-dev \
        libfreetype6 \
        libfreetype6-dev \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && apt-get remove -y --purge \
        libjpeg62-turbo-dev \
        libpng-dev \
        libfreetype6-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# intl extension
RUN apt-get update \
    && apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && apt-get remove -y --purge libicu-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# igbinary (cfr. redis & memcached below!)
RUN pecl install -o -f igbinary \
    && docker-php-ext-enable igbinary

# msgpack (cfr. memcached below!)
RUN pecl install -o -f msgpack \
    && docker-php-ext-enable --ini-name docker-php-ext-0-msgpack.ini msgpack

# redis
RUN apt-get update \
    && apt-get install -y git \
    && git clone --branch 4.2.0 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis/ \
    && docker-php-ext-configure redis --enable-redis-igbinary \
    && docker-php-ext-install -j$(nproc) redis \
    && apt-get remove -y --purge git \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /usr/src/php /var/lib/apt/lists/* /tmp/* /var/tmp/*

# memcached
RUN apt-get update \
    && apt-get install -y git libmemcached11 libmemcached-dev zlib1g-dev libmemcachedutil2 \
    && git clone --branch v3.0.4 https://github.com/php-memcached-dev/php-memcached.git /usr/src/php/ext/memcached/ \
    && docker-php-ext-configure memcached --enable-memcached-igbinary --enable-memcached-json --enable-memcached-msgpack \
    && docker-php-ext-install -j$(nproc) memcached \
    && apt-get remove -y --purge git libmemcached-dev zlib1g-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /usr/src/php /var/lib/apt/lists/* /tmp/* /var/tmp/*

# sodium extension
RUN apt-get update \
    && apt-get install -y libsodium18 libsodium-dev \
    && pecl install -o -f libsodium \
    && docker-php-ext-enable sodium \
    && apt-get remove -y --purge git libsodium-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# zip extension
RUN apt-get update \
    && apt-get install -y zlib1g-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && apt-get remove -y --purge zlib1g-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /usr/src/php /var/lib/apt/lists/* /tmp/* /var/tmp/*

# imap extension
RUN apt-get update \
    && apt-get install -y libc-client2007e libc-client2007e-dev libkrb5-3 libkrb5-dev libsasl2-2 libsasl2-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && apt-get remove -y --purge libc-client2007e-dev libkrb5-dev libsasl2-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# soap extension
RUN apt-get update \
    && apt-get install -y libxml2 libxml2-dev \
    && docker-php-ext-install -j$(nproc) soap \
    && apt-get remove -y --purge libxml2-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# xmlrpc extension
RUN apt-get update \
    && apt-get install -y libxml2 libxml2-dev \
    && docker-php-ext-install -j$(nproc) xmlrpc \
    && apt-get remove -y --purge libxml2-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# xsl extension
RUN apt-get update \
    && apt-get install -y libxslt1.1 libxslt1-dev \
    && docker-php-ext-install -j$(nproc) xsl \
    && apt-get remove -y --purge libxslt1-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Mail support
RUN apt-get update \
    && apt-get install -y ssmtp \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add wkhtmltopdf
RUN apt-get update \
    && apt-get install -y \
        fontconfig \
        libfreetype6 \
        libjpeg62-turbo \
        libpng16-16 \
        libx11-6 \
        libxcb1 \
        libxext6 \
        libxrender1 \
        xfonts-75dpi \
        xfonts-base \
    && curl -L -o /tmp/wkhtmltox_0.12.5-1.stretch_amd64.deb https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && dpkg -i /tmp/wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY mail.ini /usr/local/etc/php/conf.d/docker-php-mail.ini
COPY php.ini /usr/local/etc/php/conf.d/php.ini
