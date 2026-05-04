# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="xdg-desktop-portal-wlr"
PKG_VERSION="0.7.0"
PKG_SHA256="511e0509653d67af17c9ec45cc6ce1e43e795a444d0e51f959ff899d636f2c4e"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/emersion/xdg-desktop-portal-wlr"
PKG_URL="https://launchpad.net/ubuntu/+archive/primary/+files/${PKG_NAME}_${PKG_VERSION}.orig.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols pipewire systemd inih mesa libdrm"
PKG_LONGDESC="wlroots implementation of desktop portal (screenshot, screencast)"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dsd-bus-provider=libsystemd \
                       -Dsystemd=enabled \
                       -Dman-pages=disabled"
