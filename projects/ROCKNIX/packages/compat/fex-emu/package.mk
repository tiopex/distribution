# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025 ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="fex-emu"
PKG_VERSION="2603"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/FEX-Emu/FEX"
PKG_URL="https://github.com/tiopex/FEX-build/releases/download/FEX-${PKG_VERSION}/FEX-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="squashfs-tools squashfuse"
PKG_LONGDESC="FEX-Emu is a fast x86/x86-64 emulator for AArch64"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}/
    mkdir -p ${INSTALL}/usr
    rm -rf ${PKG_BUILD}/usr/lib/binfmt.d
    cp -r ${PKG_BUILD}/usr ${INSTALL}/
}
