# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="xdg-desktop-portal-gtk"
PKG_VERSION="1.15.1"
PKG_SHA256="425551ca5f36451d386d53599d95a3a05b94020f1a4927c5111a2c3ba3a0fe4c"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://github.com/flatpak/xdg-desktop-portal-gtk"
PKG_URL="https://launchpad.net/ubuntu/+archive/primary/+files/${PKG_NAME}_${PKG_VERSION}.orig.tar.xz"
PKG_DEPENDS_TARGET="toolchain gtk3 xdg-desktop-portal gettext:host"
PKG_LONGDESC="GTK implementation of desktop portal (file chooser, print, etc.)"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dwallpaper=disabled \
                       -Dsettings=disabled \
                       -Dappchooser=disabled \
                       -Dlockdown=disabled"

# pkg-config returns interfaces_dir as /usr/share/... (target prefix). Meson then
# treats that as a host path and gdbus-codegen fails. Point at the real sysroot.
pre_configure_target() {
  local ifdir="${SYSROOT_PREFIX}/usr/share/dbus-1/interfaces"
  sed -i "s|desktop_portal_interfaces_dir /|'${ifdir}' /|g" "${PKG_BUILD}/data/meson.build"
}
