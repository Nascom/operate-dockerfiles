# Custom PHP 8.2 cli container
FROM debian:bullseye-slim

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

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
        php8.2-bcmath \
        php8.2-bz2 \
        php8.2-cli \
        php8.2-common \
        php8.2-curl \
        php8.2-gd \
        php8.2-gmp \
        php8.2-imap \
        php8.2-intl \
        php8.2-mbstring \
        php8.2-mysql \
        php8.2-pgsql \
        php8.2-soap \
        php8.2-sqlite3 \
        php8.2-tidy \
        php8.2-xml \
        php8.2-zip \
        imagemagick \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install imagick, igbinary & redis extension from source tree for now
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y git php8.2-dev libmagick++-dev \
    && cd /tmp \
    && git clone https://github.com/Imagick/imagick \
    && cd imagick \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=imagick.so" > /etc/php/8.2/mods-available/imagick.ini \
    && phpenmod imagick \
    && cd /tmp \
    && git clone --branch 3.2.12 https://github.com/igbinary/igbinary \
    && cd igbinary \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=igbinary.so" > /etc/php/8.2/mods-available/igbinary.ini \
    && phpenmod igbinary \
    && cd /tmp \
    && git clone --branch 5.3.7 https://github.com/phpredis/phpredis \
    && cd phpredis \
    && phpize \
    && ./configure --enable-redis-igbinary \
    && make \
    && make install \
    && echo "extension=redis.so" > /etc/php/8.2/mods-available/redis.ini \
    && phpenmod redis \
    && apt-get remove -y --purge git php8.2-dev libmagick++-dev \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/
COPY php.ini /etc/php/8.2/cli/conf.d/
COPY policy.xml /etc/ImageMagick-6/policy.xml

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php", "-a"]
