# Custom PHP 8.4 cli container
FROM debian:bookworm-slim

LABEL maintainer="Christopher Bielen <christopher.bielen@dynamate.be>"

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php", "-a"]

# Install most recent version of basic utilities
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
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
    && apt-get autoremove \
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
RUN curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb \
    && dpkg -i /tmp/debsuryorg-archive-keyring.deb \
    && echo "deb [signed-by=/usr/share/keyrings/debsuryorg-archive-keyring.gpg] https://packages.sury.org/php/ bookworm main" > /etc/apt/sources.list.d/php-packages.sury.org.list \
    && apt-get update \
    && apt-get install -y \
        php8.4-bcmath \
        php8.4-bz2 \
        php8.4-cli \
        php8.4-common \
        php8.4-curl \
        php8.4-gd \
        php8.4-gmp \
        php8.4-igbinary \
        php8.4-imagick \
        php8.4-imap \
        php8.4-intl \
        php8.4-mbstring \
        php8.4-memcached \
        php8.4-mysql \
        php8.4-pgsql \
        php8.4-redis \
        php8.4-soap \
        php8.4-sqlite3 \
        php8.4-tidy \
        php8.4-xml \
        php8.4-zip \
        imagemagick \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/
COPY php.ini /etc/php/8.4/cli/conf.d/
COPY policy.xml /etc/ImageMagick-6/policy.xml
