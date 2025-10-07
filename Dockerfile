FROM archlinux:latest

RUN pacman -Syu --noconfirm gnupg base-devel meson git scdoc gtk3 gobject-introspection gtk-layer-shell archiso mkinitcpio-archiso grub bash-completion

RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builder

WORKDIR /profile
COPY . /profile
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /profile/mkpkgs.sh
RUN chmod +x /profile/mkiso.sh
RUN chown -R builder:builder /profile

ENTRYPOINT ["/entrypoint.sh"]
