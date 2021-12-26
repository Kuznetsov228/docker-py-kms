FROM ghcr.io/linuxserver/baseimage-alpine:3.15
LABEL maintainer="Adam Beardwood"
LABEL org.opencontainers.image.source="https://github.com/TheSpad/docker-py-kms"

RUN \
  apk add --update --no-cache --virtual=build-dependencies \
    git \
    gcc \
    musl-dev \
    py3-wheel \
    python3-dev && \
  apk add --no-cache --update \
    bash \
    py3-argparse \
    py3-flask \
    py3-pygments \
    python3-tkinter \
    sqlite-libs \
    py3-pip && \
  pip3 install --no-cache-dir -U pip && \
  pip3 install --no-cache-dir -U peewee tzlocal && \
  git clone https://github.com/Py-KMS-Organization/py-kms/ /tmp/py-kms && \
  mv /tmp/py-kms/py-kms /home/ && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/*

COPY root/ /

WORKDIR /home/py-kms

EXPOSE 1688/tcp

VOLUME /config
