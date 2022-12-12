# Custom PHP 8.0 cli container
FROM debian:bullseye-slim

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

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
RUN wget -O- https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php-packages.sury.org.list \
    && apt-get update \
    && apt-get install -y \
        php8.0-bcmath \
        php8.0-bz2 \
        php8.0-cli \
        php8.0-common \
        php8.0-curl \
        php8.0-gd \
        php8.0-gmp \
        php8.0-igbinary \
        php8.0-imagick \
        php8.0-imap \
        php8.0-intl \
        php8.0-mbstring \
        php8.0-memcached \
        php8.0-mysql \
        php8.0-pgsql \
        php8.0-redis \
        php8.0-soap \
        php8.0-sqlite3 \
        php8.0-tidy \
        php8.0-xml \
        php8.0-zip \
        imagemagick \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/
COPY php.ini /etc/php/8.0/cli/conf.d/
COPY policy.xml /etc/ImageMagick-6/policy.xml
