# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025 ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="fex-emu"
PKG_VERSION="871fc0a40aa81476805232d8dbda71da2efa2588"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/FEX-Emu/FEX"
PKG_URL="https://github.com/FEX-Emu/FEX.git"
PKG_DEPENDS_TARGET="toolchain llvm:host qt6:host qt6 zlib squashfuse"
PKG_DEPENDS_HOST="toolchain:host llvm:host qt6:host qt6"
PKG_LONGDESC="FEX-Emu is a fast x86/x86-64 emulator for AArch64"
PKG_TOOLCHAIN="manual"

FEX_CMAKE_OPTS=(
  -DENABLE_LTO=True
  -DCMAKE_BUILD_TYPE=Release
  -DUSE_LINKER=lld
  -DBUILD_TESTING=False
  -DBUILD_THUNKS=False
  -DENABLE_ASSERTIONS=False
  -DCMAKE_C_COMPILER="${TOOLCHAIN}/bin/clang"
  -DCMAKE_CXX_COMPILER="${TOOLCHAIN}/bin/clang++"
  -DCMAKE_LINKER="${TOOLCHAIN}/bin/ld.lld"
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_MAKE_PROGRAM=ninja
)

make_host() {
  curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
  . $HOME/.nix-profile/etc/profile.d/nix.sh
  mkdir -p "${PKG_BUILD}/.host"
  cd "${PKG_BUILD}/"
  cmake -G Ninja \
        -S "${PKG_BUILD}" \
        -B "${PKG_BUILD}/.host" \
        -DENABLE_X86_HOST_DEBUG=True \
        "${FEX_CMAKE_OPTS[@]}" \
        -DBUILD_THUNKS=True \
        -DBUILD_GUEST_THUNKS=True \
        -DBUILD_FEXCONFIG=False
  cd "${PKG_BUILD}/.host"
  ../Data/nix/cmake_enable_libfwd.sh
  ninja thunkgen guest-libs guest-libs-32
}


make_target() {

  export CFLAGS="$(echo $CFLAGS | sed 's/-mabi=lp64//g')"
  export CXXFLAGS="$(echo $CXXFLAGS | sed 's/-mabi=lp64//g')"
  export LDFLAGS="$(echo $LDFLAGS | sed 's/-mabi=lp64//g')".
  cd "${PKG_BUILD}/.${TARGET_NAME}"
  cmake -G Ninja \
		-S "${PKG_BUILD}" \
		-B "${PKG_BUILD}/.${TARGET_NAME}" \
		-DCMAKE_SYSTEM_NAME=Linux \
		-DCMAKE_SYSTEM_PROCESSOR=aarch64 \
		-DCMAKE_C_COMPILER_TARGET=aarch64-rocknix-linux-gnu \
		-DCMAKE_CXX_COMPILER_TARGET=aarch64-rocknix-linux-gnu \
        -DTUNE_CPU=generic \
		-DCMAKE_SYSROOT=${SYSROOT_PREFIX} \
		-DCMAKE_FIND_ROOT_PATH="${SYSROOT_PREFIX}" \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY \
		-DBUILD_FEXCONFIG=True \
		-DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY \
		"${FEX_CMAKE_OPTS[@]}" \
		-DUSE_HOST_THUNKGEN=True \
		-DGENERATOR_EXE=${PKG_BUILD}/.host/Bin/thunkgen \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DBUILD_THUNKS=False \
		-DQT_HOST_PATH="${TOOLCHAIN}/usr/local/qt6"

  ninja

}

makeinstall_target() {
  cd "${PKG_BUILD}/.${TARGET_NAME}"
  DESTDIR="${INSTALL}" ninja install
}

makeinstall_host() {
  mkdir -p ${SYSROOT_PREFIX}/usr/share/fex-emu/GuestThunks
  mkdir -p ${SYSROOT_PREFIX}/usr/share/fex-emu/GuestThunks_32
  cp ${PKG_BUILD}/.host/Guest/*.so ${SYSROOT_PREFIX}/usr/share/fex-emu/GuestThunks
  cp ${PKG_BUILD}/.host/Guest_32/*.so ${SYSROOT_PREFIX}/usr/share/fex-emu/GuestThunks_32
}
