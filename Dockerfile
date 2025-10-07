FROM archlinux:latest

RUN pacman -Syu --noconfirm gnupg base-devel meson git scdoc gtk3 gobject-introspection gtk-layer-shell archiso mkinitcpio-archiso grub bash-completion

RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builder

WORKDIR /profile
COPY . /profile
RUN chmod +x /profile/mkiso.sh
RUN chown -R builder:builder /profile

USER builder
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys F4FDB18A9937358364B276E9E25D679AF73C6D2F

ENV PKGDEST=/profile/pkgbuilds
RUN mkdir -p "$PKGDEST" && chmod -R 777 "$PKGDEST"

WORKDIR /profile/packages/wlogout
RUN makepkg -s --noconfirm

USER root
WORKDIR /profile
RUN mkdir -p /profile/airootfs/var/cache/pacman/localrepo
RUN repo-add /profile/airootfs/var/cache/pacman/localrepo/localrepo.db.tar.gz /profile/pkgbuilds/*.pkg.tar.zst
RUN mv /profile/airootfs/var/cache/pacman/localrepo/localrepo.db.tar.gz /profile/airootfs/var/cache/pacman/localrepo/localrepo.db
RUN mv /profile/airootfs/var/cache/pacman/localrepo/localrepo.files.tar.gz /profile/airootfs/var/cache/pacman/localrepo/localrepo.files
RUN mkdir -p /var/cache/pacman/localrepo && cp /profile/airootfs/var/cache/pacman/localrepo/* /var/cache/pacman/localrepo/
RUN echo -e "\n[localrepo]\nSigLevel = Optional TrustAll\nServer = file:///var/cache/pacman/localrepo" >> /profile/pacman.conf
