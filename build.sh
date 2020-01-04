#!/usr/bin/env sh
#######################################################################
# Get the tags for a repo from Dockerhub
# First argument is the repository and image name (e.g. library/alpine)
#######################################################################
version=1.0.0
set -eux

# Ignore any versions that aren't numbered, and build and push 
sh tags.sh curlimages/curl \
        | grep -E '^[0-9.]+$' \
        | xargs -I{CURL_VERSION} -n1 \
        sh build-image.sh {CURL_VERSION} $version-curl-{CURL_VERSION}

#Push the latest version
sh build-image.sh latest latest