FROM alpine:3.8

LABEL maintainer="Christopher Bielen <christopher.bielen@dynamate.be>"

ENV SSH_AUTH_SOCK /ssh-agent
ENV GATEWAY no

RUN apk add --no-cache autossh \
    && rm -rf /tmp/* /var/cache/apk/*

COPY docker-entrypoint /usr/local/bin

VOLUME ["/ssh-agent"]

ENTRYPOINT ["docker-entrypoint"]
