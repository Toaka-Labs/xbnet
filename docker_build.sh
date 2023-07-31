#!/usr/bin/env bash
set -e

# Build image
docker build -t xbnet:latest .

# Grab the debian package from a temporary container
docker cp $(docker create --name tc xbnet):/opt/xbnet/target/debian/xbnet_1.1.0_amd64.deb ./xbnet_1.1.0_amd64.deb && docker rm tc