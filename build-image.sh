#!/usr/bin/env sh
#######################################################################
# Build, test and push an image
# First argument is the curl version to use
# Second argument is the image tag
#######################################################################

set -eux

if [ -z "$1" ]
then
    echo "You must specify the version of the docker image curlimages/curl to use"
    exit 1
fi

if [ -z "$2" ]
then
    echo "You must specify the image tag to use"
    exit 1
fi

export CURL_VERSION=$1;
export IMAGE_TAG=$2;
docker-compose build 

# Test that it's working by making surt we can get some tags
docker-compose run docker-tags library/alpine
docker-compose run docker-tags curlimages/curl

# Push to the docker registry
docker-compose push