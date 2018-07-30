# Custom PHP 5.3 cli container
# NEVER use this for new projects!!
FROM nascom/php:5.3-base

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

VOLUME ["/app"]
WORKDIR /app

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--", "/run.sh"]
