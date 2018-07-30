# Custom PHP 7.2 cli container
FROM nascom/php:7.2-base

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

VOLUME ["/app"]
WORKDIR /app

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--", "/run.sh"]
