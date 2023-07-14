ARG DOCKER_IMAGE

FROM $DOCKER_IMAGE

ARG DOCKER_IMAGE=alpine:latest
ARG OSSLSIGNCODE_VERSION=2.6

WORKDIR /osslsigncode

# Dependencies
RUN apk add --update --upgrade --no-cache curl build-base openssl-dev curl-dev autoconf libgsf-dev git cmake

RUN git clone https://github.com/mtrojnar/osslsigncode . \
    && git checkout $OSSLSIGNCODE_VERSION \
    && mkdir build \
    && cd build \
    && cmake -S .. \
    && cmake --build .
