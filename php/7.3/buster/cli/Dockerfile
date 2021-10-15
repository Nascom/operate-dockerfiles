# Custom PHP 7.3 cli container
FROM debian:buster-slim

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Install most recent version of basic utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        wget \
        locales \
        zip \
        unzip \
        apt-transport-https \
        ca-certificates \
        xz-utils \
        gnupg \
        default-mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Brussels /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Generate locales
RUN echo 'de_DE ISO-8859-1\n\
de_DE.UTF-8 UTF-8\n\
en_GB ISO-8859-1\n\
en_GB.UTF-8 UTF-8\n\
en_US ISO-8859-1\n\
en_US.UTF-8 UTF-8\n\
fr_BE ISO-8859-1\n\
fr_BE@euro ISO-8859-15\n\
fr_BE.UTF-8 UTF-8\n\
fr_FR ISO-8859-1\n\
fr_FR@euro ISO-8859-15\n\
fr_FR.UTF-8 UTF-8\n\
nl_BE ISO-8859-1\n\
nl_BE@euro ISO-8859-15\n\
nl_BE.UTF-8 UTF-8\n\
nl_NL ISO-8859-1\n\
nl_NL@euro ISO-8859-15\n\
nl_NL.UTF-8 UTF-8\n' >> /etc/locale.gen \
    && locale-gen

# Add all PHP modules we need & cleanup
RUN wget -O- https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ buster main" > /etc/apt/sources.list.d/php-packages.sury.org.list \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php7.3-apcu \
        php7.3-apcu-bc \
        php7.3-bcmath \
        php7.3-bz2 \
        php7.3-cli \
        php7.3-common \
        php7.3-curl \
        php7.3-gd \
        php7.3-gmp \
        php7.3-imagick \
        php7.3-imap \
        php7.3-intl \
        php7.3-json \
        php7.3-mbstring \
        php7.3-memcached \
        php7.3-mysql \
        php7.3-pgsql \
        php7.3-redis \
        php7.3-soap \
        php7.3-sqlite3 \
        php7.3-tidy \
        php7.3-xml \
        php7.3-xmlrpc \
        php7.3-zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/
COPY php.ini /etc/php/7.3/cli/conf.d/
COPY policy.xml /etc/ImageMagick-6/policy.xml

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php", "-a"]
