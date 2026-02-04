#!/bin/sh

su builder << 'EOF'
gpg --recv-keys E25D679AF73C6D2F
mkdir -p "/profile/localrepo" && chmod -R 777 "/profile/localrepo"
find /profile/packages -mindepth 1 -maxdepth 1 -type d | while read folder; do
    echo "Processing folder: $folder"
    cd "$folder"
    makepkg -s -f --noconfirm
cp *.pkg.tar.zst /profile/localrepo/
done
EOF

cd /profile/localrepo
repo-add localrepo.db.tar.gz *.pkg.tar.zst
