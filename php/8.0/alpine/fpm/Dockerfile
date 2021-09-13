FROM surnet/alpine-wkhtmltopdf:3.13.5-0.12.6-small AS wkhtmltopdf

# Custom PHP 8.0 FPM container
FROM php:8.0-fpm-alpine3.13

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

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
RUN apk add --no-cache autoconf make g++ imagemagick imagemagick-dev \
    && pecl install -f imagick \
    && docker-php-ext-enable imagick \
    && apk del --no-cache autoconf make g++ imagemagick-dev \
    && rm -rf /tmp/*

# mysqli (legacy)
RUN docker-php-ext-install -j$(nproc) mysqli

# PDO extension (with mysql & postgresql support)
RUN apk add --no-cache postgresql-dev libpq mysql-client \
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
        --with-freetype \
        --with-jpeg \
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
    && git clone --branch 5.3.4 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis/ \
    && docker-php-ext-configure redis --enable-redis-igbinary \
    && docker-php-ext-install -j$(nproc) redis \
    && apk del --no-cache autoconf make g++ git \
    && rm -rf /tmp/* /usr/src/php/

# zip extension
RUN apk add --no-cache zlib zlib-dev libzip libzip-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && apk del --no-cache zlib-dev libzip-dev

# imap extension
RUN apk add --no-cache imap c-client imap-dev krb5 krb5-dev cyrus-sasl-dev openssl openssl-dev \
    && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && apk del --no-cache imap-dev krb5-dev cyrus-sasl-dev openssl-dev

# soap extension
RUN apk add --no-cache libxml2 libxml2-dev \
    && docker-php-ext-install -j$(nproc) soap \
    && apk del --no-cache libxml2-dev

# xsl extension
RUN apk add --no-cache libxslt libxslt-dev libgcrypt libgcrypt-dev \
    && docker-php-ext-install -j$(nproc) xsl \
    && apk del --no-cache libxslt-dev libgcrypt-dev

# gmp extension
RUN apk add --no-cache autoconf make g++ gmp gmp-dev \
    && docker-php-ext-install -j$(nproc) gmp \
    && apk del --no-cache autoconf make g++ gmp-dev

# wkhtmltopdf
RUN apk add --no-cache \
        libstdc++ \
        libx11 \
        libxrender \
        libxext \
        libssl1.1 \
        ca-certificates \
        fontconfig \
        freetype \
        ttf-dejavu \
        ttf-droid \
        ttf-freefont \
        ttf-liberation \
        ttf-ubuntu-font-family
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf

COPY php.ini /usr/local/etc/php/conf.d/php.ini
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

# Copy ImageMagick policy file
COPY policy.xml /etc/ImageMagick-7/policy.xml
