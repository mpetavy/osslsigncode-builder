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

# --force-rm

docker image build  --force-rm --rm -t $APP-$LDFLAG_BUILD --build-arg DOCKER_IMAGE=$DOCKER_IMAGE --build-arg OSSLSIGNCODE_VERSION=$OSSLSIGNCODE_VERSION -t $APP:$LDFLAG_BUILD -t $APP:latest -f ./Dockerfile /tmp/context

docker container create --name $APP-$LDFLAG_BUILD $APP-$LDFLAG_BUILD

docker cp $APP-$LDFLAG_BUILD:/osslsigncode/build/osslsigncode .