# Basic Varnish 4.1 container
FROM alpine:3.6

LABEL maintainer="Christopher Bielen <christopher.bielen@dynamate.be>"

ENV VARNISH_PORT 80
ENV VARNISH_MEMORY 512m

RUN apk add --no-cache varnish

COPY docker-entrypoint /docker-entrypoint

CMD ["/docker-entrypoint"]
