FROM python:2.7
MAINTAINER Betacloud Solutions GmbH (https://www.betacloud-solutions.de)

ARG VERSION
ENV VERSION ${VERSION:-4.3.0}

ARG VERSION_CLIENT
ENV VERSION_CLIENT ${VERSION_CLIENT:-3.0.0}

ARG VERSION_WEB
ENV VERSION_WEB ${VERSION_WEB:-3.2.0}

ARG DEVPI_HOST
ARG DEVPI_PASSWORD
ARG DEVPI_PORT

ENV DEVPI_HOST ${DEVPI_HOST:-0.0.0.0}
ENV DEVPI_PASSWORD ${DEVPI_PASSWORD:-password}
ENV DEVPI_PORT ${DEVPI_PORT:-3141}

ENV DEBIAN_FRONTEND noninteractive

COPY files/run.sh /run.sh

RUN apt-get update \
    && apt-get upgrade -y \
    && pip install -q -U "devpi-server==$VERSION" \
    && pip install -q -U "devpi-client==$VERSION_CLIENT" \
    && pip install -q -U "devpi-web==$VERSION_WEB" \
    && chmod +x /run.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3141
VOLUME /data
ENTRYPOINT ["/run.sh"]
