# SPDX-License-Identifier: LGPL-2.0-or-later
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="bubblewrap"
PKG_VERSION="0.11.1"
PKG_SHA256="c1b7455a1283b1295879a46d5f001dfd088c0bb0f238abb5e128b3583a246f71"
PKG_LICENSE="LGPL-2.0-or-later"
PKG_SITE="https://github.com/containers/bubblewrap"
PKG_URL="https://github.com/containers/bubblewrap/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libcap"
PKG_LONGDESC="Unprivileged sandboxing tool (bwrap) used by Flatpak and Steam pressure-vessel."
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-D man=disabled \
                       -D tests=false \
                       -D selinux=disabled \
                       -D bash_completion=disabled \
                       -D zsh_completion=disabled"
