#!/bin/sh

set -e # stop on error in script
set -x # log script steps to STDOUT

target=./bin-debian

[ -d "$target" ] && rm -rf $target

mkdir $target

APP=osslsigncode
DOCKER_IMAGE=debian:bookworm-slim
OSSLSIGNCODE_VERSION=$(<osslsigncode-version.txt)

docker image build --force-rm --rm  -t $APP --build-arg DOCKER_IMAGE=$DOCKER_IMAGE --build-arg OSSLSIGNCODE_VERSION=$OSSLSIGNCODE_VERSION -f ./Dockerfile-debian .

docker container create --name $APP-temp $APP

docker cp $APP-temp:/osslsigncode $target

docker container rm $APP-temp
docker image prune -f
