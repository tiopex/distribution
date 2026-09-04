# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="vulkan-validation-layers"
PKG_VERSION="1.4.347"
PKG_SHA256="0514e5d0ace6e435ab710684b059db319a515c2825033fb850e794cce86a1261"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-ValidationLayers"
PKG_URL="${PKG_SITE}/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3:host vulkan-headers vulkan-utility-libraries spirv-tools"
PKG_DEPENDS_UNPACK="spirv-headers"
PKG_LONGDESC="Khronos official Vulkan validation layers."
PKG_TOOLCHAIN="cmake"

configure_package() {
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libxcb libX11 libXrandr"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_DEPENDS_TARGET+=" wayland libxcb libX11 libXrandr"
  fi
}

post_unpack() {
  mkdir -p ${PKG_BUILD}/external/SPIRV-Headers
    tar --strip-components=1 \
      -xf "${SOURCES}/spirv-headers/spirv-headers-$(get_pkg_version spirv-headers).tar.gz" \
      -C "${PKG_BUILD}/external/SPIRV-Headers"
}

pre_configure_target() {
  cmake -S ${PKG_BUILD}/external/SPIRV-Headers \
        -B ${PKG_BUILD}/.spv-headers-build \
        -DCMAKE_INSTALL_PREFIX=${PKG_BUILD}/.spv-headers-install \
        -DCMAKE_BUILD_TYPE=Release
  cmake --install ${PKG_BUILD}/.spv-headers-build

  PKG_CMAKE_OPTS_TARGET="-DUPDATE_DEPS=OFF \
                         -DBUILD_TESTS=OFF \
                         -DBUILD_WERROR=OFF \
                         -DCMAKE_BUILD_TYPE=Release \
                         -DPython3_EXECUTABLE=${TOOLCHAIN}/bin/python3 \
                         -DSPIRV_HEADERS_INSTALL_DIR=${PKG_BUILD}/.spv-headers-install \
                         -DSPIRV_TOOLS_INSTALL_DIR=${SYSROOT_PREFIX}/usr \
                         -DVULKAN_HEADERS_INSTALL_DIR=${SYSROOT_PREFIX}/usr \
                         -DVULKAN_UTILITY_LIBRARIES_INSTALL_DIR=${SYSROOT_PREFIX}/usr \
                         -Wno-dev"

  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XCB_SUPPORT=ON \
                             -DBUILD_WSI_XLIB_SUPPORT=ON \
                             -DBUILD_WSI_XLIB_XRANDR_SUPPORT=ON \
                             -DBUILD_WSI_WAYLAND_SUPPORT=OFF"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XCB_SUPPORT=ON \
                             -DBUILD_WSI_XLIB_SUPPORT=ON \
                             -DBUILD_WSI_XLIB_XRANDR_SUPPORT=ON \
                             -DBUILD_WSI_WAYLAND_SUPPORT=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XCB_SUPPORT=OFF \
                             -DBUILD_WSI_XLIB_SUPPORT=OFF \
                             -DBUILD_WSI_XLIB_XRANDR_SUPPORT=OFF \
                             -DBUILD_WSI_WAYLAND_SUPPORT=OFF"
  fi
}

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i  "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/include
  safe_remove ${INSTALL}/usr/lib/cmake
  safe_remove ${INSTALL}/usr/lib/pkgconfig
}
