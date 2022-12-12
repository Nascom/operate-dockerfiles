# Custom PHP 8.1 cli container
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
        php8.1-bcmath \
        php8.1-bz2 \
        php8.1-cli \
        php8.1-common \
        php8.1-curl \
        php8.1-gd \
        php8.1-gmp \
        php8.1-igbinary \
        php8.1-imagick \
        php8.1-imap \
        php8.1-intl \
        php8.1-mbstring \
        php8.1-memcached \
        php8.1-mysql \
        php8.1-pgsql \
        php8.1-redis \
        php8.1-soap \
        php8.1-sqlite3 \
        php8.1-tidy \
        php8.1-xml \
        php8.1-zip \
        imagemagick \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/
COPY php.ini /etc/php/8.1/cli/conf.d/
COPY policy.xml /etc/ImageMagick-6/policy.xml
