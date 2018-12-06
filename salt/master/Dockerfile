# Custom Salt & Salt API container
FROM debian:stretch

LABEL maintainer="Wim Vandersmissen <wim.vandersmissen@nascom.be>"

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        wget \
        apt-transport-https \
        ca-certificates \
        gnupg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add Salt repo (for now we have to upgrade cherrypy because the stock version fails with SSL)
RUN echo "deb http://repo.saltstack.com/apt/debian/9/amd64/latest stretch main" >> /etc/apt/sources.list.d/saltstack.list \
    && wget -O - https://repo.saltstack.com/apt/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        salt-master \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV SALT_API_USER saltapi
ENV SALT_API_PASSWORD saltapi

ADD salt-api.conf /etc/salt/master.d/salt-api.conf
ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 4505 4506

CMD ["/run.sh"]
