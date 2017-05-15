# Custom PHP 7.1 cli container
FROM nascom/php:7.1-base

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

VOLUME ["/app"]
WORKDIR /app

# Enable libsodium
RUN phpenmod libsodium

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--", "/usr/bin/php"]
