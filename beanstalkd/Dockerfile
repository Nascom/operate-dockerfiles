FROM debian:stretch

LABEL maintainer="Christopher Bielen <christopher.bielen@dynamate.be>"

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        beanstalkd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV BEANSTALK_PORT 11300

COPY run.sh       /run.sh

EXPOSE 11300

CMD ["/bin/bash", "/run.sh"]
