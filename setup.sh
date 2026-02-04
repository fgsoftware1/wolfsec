#!/bin/bash

set -e

echo "Installing dependencies..."
sudo pacman -S archiso mkinitcpio-archiso git base-devel gnupg ovmf qemu-desktop qemu-system-x86

echo "Building custom packages..."
cd packages/wlogout
makepkg -s --noconfirm
cd ../..

echo "Setting up local repository..."
mkdir -p localrepo
cp packages/wlogout/*.pkg.tar.zst localrepo/
repo-add localrepo/localrepo.db.tar.gz localrepo/*.pkg.tar.zst
mv localrepo/localrepo.db.tar.gz localrepo/localrepo.db
mv localrepo/localrepo.files.tar.gz localrepo/localrepo.files

echo "Updating pacman.conf..."
echo -e "\n[localrepo]\nSigLevel = Optional TrustAll\nServer = file://$(pwd)/localrepo" >> pacman.conf

echo "Building ISO..."
./mkiso.sh

echo "Run bash run-qemu.sh to test the ISO in QEMU(It will run in UEFI mode by default, for BIOS remove the "-bios" flag on the script)."