#!/bin/sh

set -e # stop on error in script
set -x # log script steps to STDOUT

target=./bin-alpine

[ -d "$target" ] && rm -rf $target

mkdir $target

APP=osslsigncode-alpine
DOCKER_IMAGE=alpine:latest
OSSLSIGNCODE_VERSION=$(cat osslsigncode-version.txt)

docker image build --force-rm --rm  -t $APP:$OSSLSIGNCODE_VERSION --build-arg DOCKER_IMAGE=$DOCKER_IMAGE --build-arg OSSLSIGNCODE_VERSION=$OSSLSIGNCODE_VERSION -f ./Dockerfile-alpine .

docker container create --name $APP-temp $APP:$OSSLSIGNCODE_VERSION

docker cp $APP-temp:/osslsigncode $target

docker container rm $APP-temp
docker image prune -f
