# Custom PHP 7.4 cli container
FROM debian:bullseye-slim

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

# Install most recent version of basic utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        wget \
        locales \
        git \
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

# Add all PHP modules we need & cleanup
RUN wget -O- https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php-packages.sury.org.list \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php7.4-apcu \
        php7.4-apcu-bc \
        php7.4-bcmath \
        php7.4-bz2 \
        php7.4-cli \
        php7.4-common \
        php7.4-curl \
        php7.4-gd \
        php7.4-gmp \
        php7.4-imagick \
        php7.4-imap \
        php7.4-intl \
        php7.4-json \
        php7.4-mbstring \
        php7.4-memcached \
        php7.4-mysql \
        php7.4-pgsql \
        php7.4-redis \
        php7.4-soap \
        php7.4-sqlite3 \
        php7.4-tidy \
        php7.4-xml \
        php7.4-xmlrpc \
        php7.4-zip \
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
    && curl -L -o /tmp/wkhtmltox_0.12.6-1.buster_amd64.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb \
    && dpkg -i /tmp/wkhtmltox_0.12.6-1.buster_amd64.deb \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add pdftk
RUN apt-get update \
    && apt-get install -y \
        pdftk \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/
COPY php.ini /etc/php/7.4/cli/conf.d/
COPY policy.xml /etc/ImageMagick-6/policy.xml

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php", "-a"]
