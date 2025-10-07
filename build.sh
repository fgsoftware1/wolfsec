#!/bin/sh

docker run --privileged -it -v ${PWD}:/profile 'ghcr.io/fgsoftware1/wolfsec:master'