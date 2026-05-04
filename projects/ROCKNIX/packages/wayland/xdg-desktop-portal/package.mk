# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="xdg-desktop-portal"
PKG_VERSION="1.18.4"
PKG_SHA256="b858aa1e74e80c862790dbb912906e6eab8b1e4db9339cd759473af62b461e65"
PKG_LICENSE="LGPL-2.0-or-later"
PKG_SITE="https://github.com/flatpak/xdg-desktop-portal"
PKG_URL="https://launchpad.net/ubuntu/+archive/primary/+files/${PKG_NAME}_${PKG_VERSION}.orig.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib json-glib fuse3 gdk-pixbuf pipewire systemd gettext:host"
PKG_LONGDESC="Desktop integration portal D-Bus front-end (Flatpak/host app integration)"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dgeoclue=disabled \
                       -Dlibportal=disabled \
                       -Dsystemd=enabled \
                       -Dman-pages=disabled \
                       -Ddocbook-docs=disabled \
                       -Dpytest=disabled \
                       -Dflatpak-interfaces=disabled \
                       -Dsandboxed-image-validation=false"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/xdg-desktop-portal
  cp -f ${PKG_DIR}/portals.conf ${INSTALL}/usr/share/xdg-desktop-portal/portals.conf
}
