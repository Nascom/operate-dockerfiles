# Custom PHP 5.3 base container for old legacy projects
# NEVER use this for new projects!!
FROM debian:squeeze

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

# Install basic utilities
RUN echo "deb http://archive.debian.org/debian squeeze main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian squeeze-lts main" >> /etc/apt/sources.list \
    && echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        wget \
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

RUN echo Europe/Brussels > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

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

# Add wkhtmltopdf
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libxrender1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && wget -O /tmp/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz https://downloads.wkhtmltopdf.org/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar -C /usr/local -xf /tmp/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && ln -s /usr/local/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf \
    && ln -s /usr/local/wkhtmltox/bin/wkhtmltoimage /usr/local/bin/wkhtmltoimage \
    && rm -rf /tmp/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

# Add all PHP modules we need & cleanup
RUN echo "deb http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list.d/dotdeb.org.list \
    && echo "deb-src http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list.d/dotdeb.org.list \
    && wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        php-apc \
        php5-cli \
        php5-curl \
        php5-gd \
        php5-imagick \
        php5-imap \
        php5-intl \
        php5-json \
        php5-mcrypt \
        php5-memcached \
        php5-mysql \
        php-pear \
        php-soap \
        php5-tidy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV SMTP_SERVER mail
ENV ROOT_EMAIL admin@nascom.be

COPY mail.ini   /etc/php5/cli/conf.d/
COPY php.ini    /etc/php5/cli/conf.d/
COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
# Quickfix to make sure users can run container with custom config
RUN  chmod a+w  /etc/ssmtp
RUN  chmod a+w  /etc/ssmtp/ssmtp.conf
