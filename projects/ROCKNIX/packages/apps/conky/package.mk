# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2025 Example

PKG_NAME="conky"
PKG_VERSION="3c055d05c29e139ad651b34ee3b4d73e649ea03d"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/brndnmtthws/conky"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain pango lua54 cairo wayland wayland-protocols"
PKG_LONGDESC="Lightweight system monitor for X11 and Linux with Lua scripting support."
PKG_TOOLCHAIN="cmake"

pre_configure_target() {
  SYSROOT="${SYSROOT_PREFIX}"
  mkdir -p "${SYSROOT}/usr/share/wayland-protocols/unstable"
  ln -sf "${PKG_BUILD}/src/wl_protocols/wlr-layer-shell-unstable-v1.xml" \
         "${SYSROOT}/usr/share/wayland-protocols/unstable/wlr-layer-shell-unstable-v1.xml"
}
PKG_CMAKE_OPTS_TARGET="
-DBUILD_X11=OFF \
-DBUILD_WAYLAND=ON"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/conky
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/conky
}

