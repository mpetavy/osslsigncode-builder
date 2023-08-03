#!/bin/sh

set -e # stop on error in script
set -x # log script steps to STDOUT

export target=./bin-alpine

[ -d "$target" ] && rm -rf $target

mkdir $target

export APP=osslsigncode
export DOCKER_IMAGE=alpine:latest
export OSSLSIGNCODE_VERSION=2.6

docker image build --force-rm --rm  -t $APP --build-arg DOCKER_IMAGE=$DOCKER_IMAGE --build-arg OSSLSIGNCODE_VERSION=$OSSLSIGNCODE_VERSION -f ./Dockerfile-alpine .

docker container create --name $APP-temp $APP

docker cp $APP-temp:/osslsigncode $target

docker container rm $APP-temp
docker image prune -f