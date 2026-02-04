#!/bin/sh

cd /profile
./pullpkgs.sh && \
./mkpkgs.sh && \
./mkiso.sh