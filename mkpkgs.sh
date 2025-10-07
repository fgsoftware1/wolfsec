#!/bin/sh

su builder << 'EOF'
gpg --keyserver keyserver.ubuntu.com --recv-keys F4FDB18A9937358364B276E9E25D679AF73C6D2F
export PKGDEST=/profile/localrepo
mkdir -p "$PKGDEST" && chmod -R 777 "$PKGDEST"
cd /profile/packages/wlogout
makepkg -s -f --noconfirm
EOF

cd /profile
repo-add /profile/localrepo/localrepo.db.tar.gz /profile/localrepo/*.pkg.tar.zst
mv /profile/localrepo/localrepo.db.tar.gz /profile/localrepo/localrepo.db
mv /profile/localrepo/localrepo.files.tar.gz /profile/localrepo/localrepo.files
echo -e "\n[localrepo]\nSigLevel = Optional TrustAll\nServer = file:///profile/localrepo" >> /profile/pacman.conf
