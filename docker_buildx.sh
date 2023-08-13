#!/usr/bin/env bash
set -e

if [[ $(docker buildx inspect xbnetbuilder) ]]; then
    echo xbnetbuilder found!
else
    docker buildx create --name xbnetbuilder
fi

docker buildx use xbnetbuilder
docker buildx inspect --bootstrap

docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t xbnet:latest -o build .
