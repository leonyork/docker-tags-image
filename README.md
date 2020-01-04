# Ansible Docker images

Images for getting the tags for a public docker hub image. Sorts the tags by version using [sort](https://en.wikipedia.org/wiki/Sort_(Unix)#Sort_by_version).

## Build

```docker build --build-arg CURL_VERSION=7.67.0 -t leonyork/docker-tags .```

## Test

```docker run leonyork/docker-tags curlimages/curl```