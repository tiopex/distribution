# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="adwaita-icon-theme"
PKG_VERSION="47.0"
PKG_SHA256="ad088a22958cb8469e41d9f1bba0efb27e586a2102213cd89cc26db2e002bdfe"
PKG_LICENSE="LGPL-3 CC-BY-SA-3"
PKG_SITE="https://gitlab.gnome.org/GNOME/adwaita-icon-theme"
PKG_URL="https://download.gnome.org/sources/${PKG_NAME}/${PKG_VERSION%%.*}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Default GNOME / GTK icon theme (Adwaita)"

PKG_TOOLCHAIN="meson"
