# Basic Varnish 5.2 container
FROM alpine:3.7

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

ENV VARNISH_PORT 80
ENV VARNISH_MEMORY 512m

RUN apk add --no-cache varnish

COPY docker-entrypoint /docker-entrypoint

CMD ["/docker-entrypoint"]
