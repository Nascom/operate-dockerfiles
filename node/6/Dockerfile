# Basic node container with Ctrl-C support
FROM node:6

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

# Hack needed to make sure git clone works?
RUN git config --system user.name Docker && git config --system user.email docker@localhost

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
