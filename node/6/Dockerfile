# Basic node container with Ctrl-C support
FROM node:6

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
