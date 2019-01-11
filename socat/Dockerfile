FROM alpine

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

RUN apk add --no-cache socat \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT ["socat"]
