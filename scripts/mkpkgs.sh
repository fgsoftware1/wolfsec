#!/bin/sh

set -e

su builder << 'BUILDEOF'
set -e
gpg --recv-keys F4FDB18A9937358364B276E9E25D679AF73C6D2F || true
mkdir -p /profile/localrepo && chmod -R 777 /profile/localrepo
find /profile/packages -mindepth 1 -maxdepth 1 -type d | while read folder; do
    echo "=== Building: $folder ==="
    cd "$folder"
    if makepkg -s -f --noconfirm; then
        cp *.pkg.tar.zst /profile/localrepo/
        echo "OK: $(basename "$folder")"
    else
        echo "FAILED: $(basename "$folder")"
    fi
done
BUILDEOF

cd /profile/localrepo
if ls *.pkg.tar.zst 1>/dev/null 2>&1; then
    repo-add localrepo.db.tar.gz *.pkg.tar.zst
    echo "=== Packages in localrepo ==="
    tar -tzf localrepo.db.tar.gz | grep '/desc$' | sed 's|/desc||'
else
    echo "ERROR: No packages were built. Cannot create localrepo."
    exit 1
fi
