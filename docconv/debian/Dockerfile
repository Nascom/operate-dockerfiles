FROM golang:1.14-buster AS build

RUN go get code.sajari.com/docconv/...

FROM debian:buster-slim

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
       zip \
       poppler-utils \
       wv \
       tidy \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8888

COPY --from=build /go/bin/docd /usr/local/bin/docd

COPY docker-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-entrypoint"]

CMD ["docd"]
