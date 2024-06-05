# Custom Elasticsearch 6.8 container, heavily inspired by the official one but using Debian packages ...
FROM debian:12-slim

RUN apt-get update \
    && apt-get install -y apt-transport-https openjdk-17-jre-headless curl procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN groupadd -g 1000 elasticsearch \
    && adduser --uid 1000 --gid 1000 --home /usr/share/elasticsearch --shell /bin/bash elasticsearch \
    && adduser elasticsearch root

WORKDIR /usr/share/elasticsearch

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV discovery.type=single-node

RUN curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.23.tar.gz \
    && tar -xvf elasticsearch-6.8.23.tar.gz --strip-components=1 \
    && rm elasticsearch-6.8.23.tar.gz

COPY ./config/elasticsearch.yml config/elasticsearch.yml
COPY ./config/log4j2.properties config/log4j2.properties
COPY ./bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod 0555 /usr/local/bin/docker-entrypoint.sh \
    && mkdir data \
    && sed -i 's/^[^#]*UseAVX/#&/' config/jvm.options \
    && chown -R 0:0 /usr/share/elasticsearch \
    && chmod 0775 /usr/share/elasticsearch \
    && chown elasticsearch bin config data logs plugins

EXPOSE 9200 9300

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

USER 1000:0
