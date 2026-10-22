FROM alpine

LABEL maintainer="Christopher Bielen <christopher.bielen@dynamate.be>"

RUN apk add --no-cache socat \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT ["socat"]
