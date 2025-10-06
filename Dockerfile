FROM archlinux:latest

RUN pacman -Syu --noconfirm archiso mkinitcpio-archiso grub bash-completion

WORKDIR /profile

CMD ["/bin/bash"]