#
FROM debian:jessie

MAINTAINER Wim Vandersmissen <wim.vandersmissen@nascom.be>

# Install most recent version of basic utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        rsyslog \
        postfix \
        mailutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Brussels /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Add group and user for virtual mail
RUN groupadd -g 3001 vmail \
    && useradd -m -d /vmail -u 3001 -g 3001 -s /sbin/nologin vmail \
    && chmod 755 /vmail \
    && usermod -G vmail postfix

# Add secure directory
RUN mkdir -p /secure/postfix \
    && touch /secure/postfix/vmaps /secure/postfix/vhosts

EXPOSE 25
EXPOSE 587

COPY run.sh /run.sh

CMD ["/bin/bash", "/run.sh"]
