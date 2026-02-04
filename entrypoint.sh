#!/bin/sh

set -e

cd /profile

./scripts/pullpkgs.sh
./scripts/mkpkgs.sh

# generate build pacman.conf with localrepo
cp pacman.conf pacman-build.conf
printf '\n[localrepo]\nSigLevel = Optional TrustAll\nServer = file:///profile/localrepo\n' >> pacman-build.conf

./scripts/mkiso.sh

rm -f pacman-build.conf
