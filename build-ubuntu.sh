#!/bin/sh

set -e # stop on error in script
set -x # log script steps to STDOUT

export APP=osslsigncode
export DOCKER_IMAGE=ubuntu:latest
export OSSLSIGNCODE_VERSION=2.6

docker image build --force-rm --rm  -t $APP --build-arg DOCKER_IMAGE=$DOCKER_IMAGE --build-arg OSSLSIGNCODE_VERSION=$OSSLSIGNCODE_VERSION -f ./Dockerfile-ubuntu .

docker container create --name $APP-temp $APP

docker cp $APP-temp:/osslsigncode ./osslsigncode-ubuntu

docker container rm $APP-temp
docker image prune -f