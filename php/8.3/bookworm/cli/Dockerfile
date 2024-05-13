# Custom PHP 8.3 cli container
FROM debian:bookworm-slim

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
    && echo "deb https://packages.sury.org/php/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/php-packages.sury.org.list \
    && apt-get update \
    && apt-get install -y \
        php8.3-bcmath \
        php8.3-bz2 \
        php8.3-cli \
        php8.3-common \
        php8.3-curl \
        php8.3-gd \
        php8.3-gmp \
        php8.3-igbinary \
        php8.3-imagick \
        php8.3-imap \
        php8.3-intl \
        php8.3-mbstring \
        php8.3-memcached \
        php8.3-mysql \
        php8.3-pgsql \
        php8.3-redis \
        php8.3-soap \
        php8.3-sqlite3 \
        php8.3-tidy \
        php8.3-xml \
        php8.3-zip \
        imagemagick \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/
COPY php.ini /etc/php/8.3/cli/conf.d/
COPY policy.xml /etc/ImageMagick-6/policy.xml
