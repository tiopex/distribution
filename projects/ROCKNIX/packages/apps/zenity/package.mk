# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="zenity"
PKG_VERSION="3.44.4"
PKG_SHA256="f1a4c958f4d4103f644457e440fd4bd86cf8b0502e9ace06002c98e36cd84a18"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://wiki.gnome.org/Projects/Zenity"
PKG_URL="https://download.gnome.org/sources/zenity/${PKG_VERSION:0:4}/zenity-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gtk3 gettext:host hicolor-icon-theme adwaita-icon-theme shared-mime-info"
PKG_LONGDESC="Display GTK+ dialogs from the shell"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dlibnotify=false \
                       -Dwebkitgtk=false"
