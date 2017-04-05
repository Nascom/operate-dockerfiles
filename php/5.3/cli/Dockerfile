# Custom PHP 5.3 cli container
# NEVER use this for new projects!!
FROM nascom/php:5.3-base

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

VOLUME ["/app"]
WORKDIR /app

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--", "/usr/bin/php"]
