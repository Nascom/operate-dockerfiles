FROM golang:1.14-alpine3.11 AS build

RUN apk add --no-cache git \
    && go get code.sajari.com/docconv/...

FROM alpine:3.11

RUN apk add --no-cache \
      tidyhtml \
      poppler-utils \
      wv

EXPOSE 8888

COPY --from=build /go/bin/docd /usr/local/bin/docd

COPY docker-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-entrypoint"]

CMD ["docd"]
