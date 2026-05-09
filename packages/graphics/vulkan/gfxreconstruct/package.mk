# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="gfxreconstruct"
PKG_VERSION="vulkan-sdk-1.4.309.0"
PKG_SHA256="bdac14fb3d946f5a982c929e9249eed218d97a3512aaae5ca426f6213b124e11"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/LunarG/gfxreconstruct"
PKG_URL="https://github.com/LunarG/gfxreconstruct/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vulkan-loader vulkan-headers zlib lz4 zstd"
PKG_LONGDESC="GFXReconstruct - Graphics API Capture and Replay Tools for Vulkan"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release \
                       -DBUILD_STATIC=OFF \
                       -DBUILD_WERROR=OFF \
                       -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
                       -DVULKAN_HEADER=${SYSROOT_PREFIX}/usr/include/vulkan/vulkan_core.h"

post_unpack() {
  # Populate git submodules that are not included in the release tarball

  # Vulkan-Headers - symlink to system headers
  rm -rf ${PKG_BUILD}/external/Vulkan-Headers
  mkdir -p ${PKG_BUILD}/external/Vulkan-Headers/include
  ln -sf ${SYSROOT_PREFIX}/usr/include/vulkan ${PKG_BUILD}/external/Vulkan-Headers/include/vulkan

  # SPIRV-Reflect
  if [ ! -f ${PKG_BUILD}/external/SPIRV-Reflect/CMakeLists.txt ]; then
    rm -rf ${PKG_BUILD}/external/SPIRV-Reflect
    git clone --depth 1 https://github.com/KhronosGroup/SPIRV-Reflect.git ${PKG_BUILD}/external/SPIRV-Reflect
  fi

  # SPIRV-Headers (needed by SPIRV-Reflect)
  if [ ! -f ${PKG_BUILD}/external/SPIRV-Headers/CMakeLists.txt ]; then
    rm -rf ${PKG_BUILD}/external/SPIRV-Headers
    git clone --depth 1 https://github.com/KhronosGroup/SPIRV-Headers.git ${PKG_BUILD}/external/SPIRV-Headers
  fi

  # Fix nlohmann CMake minimum version for CMake >= 3.27
  sed -i 's/cmake_minimum_required(VERSION 3.1)/cmake_minimum_required(VERSION 3.5)/' ${PKG_BUILD}/external/nlohmann/CMakeLists.txt 2>/dev/null || true
}

pre_make_target() {
  # Fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}
