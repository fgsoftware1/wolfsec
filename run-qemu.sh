#!/bin/sh

qemu-system-x86_64 -cdrom out/archlinux-$(date +"%Y.%m.%d")-x86_64.iso -m 2G -enable-kvm -smp 2 -bios /usr/share/ovmf/OVMF.fd -boot d -display gtk,gl=on,grab-on-hover=on,zoom-to-fit=on