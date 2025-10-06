#!/bin/sh

docker build --pull --rm -f 'Dockerfile' -t 'wolfsec:latest' '.'
docker run --privileged -it -v ${PWD}:/profile 'wolfsec'