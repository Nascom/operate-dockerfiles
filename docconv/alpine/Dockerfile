FROM golang:1.19-alpine3.17 AS build

RUN apk add --no-cache git \
    && GO111MODULE=off go get code.sajari.com/docconv/...

FROM alpine:3.17

RUN apk add --no-cache \
      tidyhtml \
      poppler-utils \
      wv

EXPOSE 8888

COPY --from=build /go/bin/docd /usr/local/bin/docd

COPY docker-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-entrypoint"]

CMD ["docd"]
