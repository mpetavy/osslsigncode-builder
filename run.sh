#!/bin/sh

set -e # stop on error in script
set -x # log script steps to STDOUT

[ -f "/tmp/context" ] && rm /tmp/context
[ -d "/tmp/context" ] && rm -rf /tmp/context

mkdir /tmp/context

export APP=osslsigncode
export LDFLAG_BUILD=1
export DOCKER_IMAGE=alpine:latest
export OSSLSIGNCODE_VERSION=2.6
export OSSLSIGNCODE_HASH=0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5

# --force-rm

docker build --build-arg DOCKER_IMAGE=$DOCKER_IMAGE --build-arg OSSLSIGNCODE_VERSION=$OSSLSIGNCODE_VERSION --build-arg OSSLSIGNCODE_HASH=$OSSLSIGNCODE_HASH -t $APP:$LDFLAG_BUILD -t $APP:latest -f ./Dockerfile /tmp/context