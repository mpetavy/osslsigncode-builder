#!/bin/sh

set -e # stop on error in script
set -x # log script steps to STDOUT

[ -f "/tmp/context" ] && rm /tmp/context
[ -d "/tmp/context" ] && rm -rf /tmp/context

mkdir /tmp/context

export APP=osslsigncode
export DOCKER_IMAGE=alpine:latest
export OSSLSIGNCODE_VERSION=2.6

# --force-rm

docker image build --force-rm --rm  -t $APP --build-arg DOCKER_IMAGE=$DOCKER_IMAGE --build-arg OSSLSIGNCODE_VERSION=$OSSLSIGNCODE_VERSION -f ./Dockerfile /tmp/context

docker container create --name $APP-temp $APP

docker cp $APP-temp:/osslsigncode .

docker container rm $APP-temp
docker image prune -f