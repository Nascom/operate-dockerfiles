FROM surnet/alpine-wkhtmltopdf:3.7-0.12.5-small AS wkhtmltopdf

# Custom PHP 7.3 FPM container
FROM php:7.3-fpm-alpine

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

ENV PHP_FPM_UID 33
ENV PHP_FPM_GID 33

RUN apk add --no-cache shadow \
    && docker-php-ext-enable opcache

# bcmath extension
RUN docker-php-ext-install -j$(nproc) bcmath

# calendar extension
RUN docker-php-ext-install -j$(nproc) calendar

# gettext extension
RUN apk add --no-cache gettext gettext-dev \
    && docker-php-ext-install -j$(nproc) gettext \
    && apk del --no-cache gettext-dev

# exif extension
RUN docker-php-ext-install -j$(nproc) exif

# iconv extension
RUN docker-php-ext-install -j$(nproc) iconv

# imagick extension
RUN apk add --no-cache autoconf make g++ imagemagick6 imagemagick6-dev \
    && pecl install -f imagick \
    && docker-php-ext-enable imagick \
    && apk del --no-cache autoconf make g++ imagemagick6-dev \
    && rm -rf /tmp/*

# mysqli (legacy)
RUN docker-php-ext-install -j$(nproc) mysqli

# PDO extension (with mysql & postgresql support)
RUN apk add --no-cache postgresql-dev libpq \
    && docker-php-ext-install -j$(nproc) pdo pdo_mysql pdo_pgsql \
    && apk del --no-cache postgresql-dev

# sockets extension
RUN docker-php-ext-install -j$(nproc) sockets

# BZip2 extension
RUN apk add --no-cache bzip2 bzip2-dev \
    && docker-php-ext-install -j$(nproc) bz2 \
    && apk del --no-cache bzip2-dev

# gd extension
RUN apk add --no-cache \
        freetype \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && apk del --no-cache \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev

# intl extension
RUN apk add --no-cache icu icu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && apk del --no-cache icu-dev

# igbinary
RUN apk add --no-cache autoconf make g++ \
    && pecl install -o -f igbinary \
    && docker-php-ext-enable igbinary \
    && apk del --no-cache autoconf make g++ \
    && rm -rf /tmp/*

# msgpack
#RUN apk add --no-cache autoconf make g++ \
#    && pecl install -o -f msgpack \
#    && docker-php-ext-enable --ini-name docker-php-ext-0-msgpack.ini msgpack \
#    && apk del --no-cache autoconf make g++ \
#    && rm -rf /tmp/*

# redis
RUN apk add --no-cache autoconf make g++ git \
    && git clone --branch 4.0.2 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis/ \
    && docker-php-ext-configure redis --enable-redis-igbinary \
    && docker-php-ext-install -j$(nproc) redis \
    && apk del --no-cache autoconf make g++ git \
    && rm -rf /tmp/* /usr/src/php/

# memcached
#RUN apk add --no-cache autoconf make g++ git libmemcached libmemcached-dev zlib-dev \
#    && git clone --branch v3.0.4 https://github.com/php-memcached-dev/php-memcached.git /usr/src/php/ext/memcached/ \
#    && docker-php-ext-configure memcached --enable-memcached-igbinary --enable-memcached-json --enable-memcached-msgpack \
#    && docker-php-ext-install -j$(nproc) memcached \
#    && apk del --no-cache autoconf make g++ git libmemcached-dev zlib-dev \
#    && rm -rf /tmp/* /usr/src/php/

# zip extension
RUN apk add --no-cache zlib zlib-dev libzip libzip-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && apk del --no-cache zlib-dev libzip-dev

# imap extension
RUN apk add --no-cache imap c-client imap-dev krb5 krb5-dev cyrus-sasl-dev openssl openssl-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && apk del --no-cache imap-dev krb5-dev cyrus-sasl-dev openssl-dev

# soap extension
RUN apk add --no-cache libxml2 libxml2-dev \
    && docker-php-ext-install -j$(nproc) soap \
    && apk del --no-cache libxml2-dev

# xmlrpc extension
RUN apk add --no-cache libxml2-dev \
    && docker-php-ext-install -j$(nproc) xmlrpc \
    && apk del --no-cache libxml2-dev

# xsl extension
RUN apk add --no-cache libxslt libxslt-dev \
    && docker-php-ext-install -j$(nproc) xsl \
    && apk del --no-cache libxslt-dev

# wkhtmltopdf
RUN apk add --no-cache \
        libstdc++ \
        libx11 \
        libxrender \
        libxext \
        libssl1.0 \
        ca-certificates \
        fontconfig \
        freetype \
        ttf-dejavu \
        ttf-droid \
        ttf-freefont \
        ttf-liberation \
        ttf-ubuntu-font-family
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf

# Mail support
RUN apk add --no-cache ssmtp \
    && rm -rf /tmp/* /var/cache/apk/*
COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY mail.ini /usr/local/etc/php/conf.d/docker-php-mail.ini
COPY php.ini /usr/local/etc/php/conf.d/php.ini

COPY docker-php-entrypoint /usr/local/bin/
