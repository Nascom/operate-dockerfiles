# Custom PHP 5.6 base container
# Should NOT be used for new projects unless it's required by the hosting provider
FROM nascom/php:5.6-base

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

VOLUME ["/app"]
WORKDIR /app

# Enable libsodium
RUN phpenmod libsodium

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--", "/usr/bin/php"]
