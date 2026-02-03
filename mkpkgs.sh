#!/bin/sh

su builder << 'EOF'
gpg --recv-keys E25D679AF73C6D2F
mkdir -p "/profile/localrepo" && chmod -R 777 "/profile/localrepo"
cd /profile/packages/wlogout
makepkg -s -f --noconfirm
cp *.pkg.tar.zst /profile/localrepo/
EOF

cd /profile/localrepo
repo-add localrepo.db.tar.gz *.pkg.tar.zst
