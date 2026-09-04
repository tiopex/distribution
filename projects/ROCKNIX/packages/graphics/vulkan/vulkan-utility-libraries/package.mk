# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="vulkan-utility-libraries"
PKG_VERSION="1.4.347"
PKG_SHA256="8ef5e9cde04a11b94903df9763b052c20accd64473f2aeb23abf531cb6d0c239"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Utility-Libraries"
PKG_URL="${PKG_SITE}/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vulkan-headers"
PKG_LONGDESC="Utility libraries for Vulkan components (layer settings, safe struct, headers)."
PKG_TOOLCHAIN="cmake"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DUPDATE_DEPS=OFF \
                         -DBUILD_TESTS=OFF \
                         -DCMAKE_BUILD_TYPE=Release"
}

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr
}
