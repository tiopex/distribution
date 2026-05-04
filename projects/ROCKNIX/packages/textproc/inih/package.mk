# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="inih"
PKG_VERSION="r62"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/benhoyt/inih"
PKG_URL="https://github.com/benhoyt/inih/archive/${PKG_VERSION}.tar.gz"
PKG_SHA256="9c15fa751bb8093d042dae1b9f125eb45198c32c6704cd5481ccde460d4f8151"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Simple .INI file parser (C library, pkg-config name: inih)"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Ddistro_install=true \
                       -Dtests=false \
                       -Dwith_INIReader=false"
