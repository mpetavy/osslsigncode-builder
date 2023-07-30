ARG DOCKER_IMAGE=alpine:latest

FROM $DOCKER_IMAGE as builder

ARG OSSLSIGNCODE_VERSION=2.6

WORKDIR /osslsigncode

# Dependencies
RUN apk add --update --upgrade --no-cache curl build-base openssl-dev curl-dev autoconf libgsf-dev git cmake  \
    && git clone https://github.com/mtrojnar/osslsigncode . \
    && git checkout $OSSLSIGNCODE_VERSION \
    && mkdir build \
    && cd build \
    && cmake -S .. \
    && cmake --build .

FROM $DOCKER_IMAGE

RUN apk add --update --upgrade --no-cache curl 

COPY --from=0 /osslsigncode/build/osslsigncode ./

ENTRYPOINT [ "./osslsigncode" ]