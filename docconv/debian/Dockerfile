FROM golang:1.19-bullseye AS build

RUN GO111MODULE=off go get code.sajari.com/docconv/...

FROM debian:bullseye-slim

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
