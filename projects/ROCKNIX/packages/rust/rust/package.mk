# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="rust"
PKG_VERSION="1.94.0"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_DEPENDS_HOST="toolchain"
PKG_LONGDESC="A systems programming language that prevents segfaults, and guarantees thread safety."
PKG_TOOLCHAIN="manual"

case "${MACHINE_HARDWARE_NAME}" in
  "aarch64")
    PKG_SHA256="c6fd6d1c925ed986df3b2c0b89bbc90ce15afb62e4d522a054e7d50c856b3c1a"
    PKG_URL="https://static.rust-lang.org/dist/rust-${PKG_VERSION}-${MACHINE_HARDWARE_NAME}-unknown-linux-gnu.tar.xz"
    ;;
  "arm")
    PKG_SHA256="4a66d45bbc4b2e9c6aaaa62807da8e054340010b2d763c28ed2351c7a2a36972"
    PKG_URL="https://static.rust-lang.org/dist/rust-${PKG_VERSION}-${MACHINE_HARDWARE_NAME}-unknown-linux-gnueabihf.tar.xz"
    ;;
  "x86_64")
    PKG_SHA256="e8fa4185f3ef6ae32725ff638b1ecdbff28f5d651dc0b3111e2539350d03b15a"
    PKG_URL="https://static.rust-lang.org/dist/rust-${PKG_VERSION}-${MACHINE_HARDWARE_NAME}-unknown-linux-gnu.tar.xz"
    ;;
esac
PKG_SOURCE_NAME="rust_${PKG_VERSION}_${MACHINE_HARDWARE_NAME}.tar.xz"

_install_rust_std() {
  local target="$1" hash="$2"
  local tar="${PKG_BUILD}/rust-std-${target}.tar.xz"
  local url="https://static.rust-lang.org/dist/rust-std-${PKG_VERSION}-${target}.tar.xz"

  [ -f "${tar}" ] || curl -Lo "${tar}" "${url}"
  echo "${hash}  ${tar}" | sha256sum -c -
  mkdir -p "${PKG_BUILD}/rust-std-${target}"
  tar -xf "${tar}" -C "${PKG_BUILD}/rust-std-${target}" --strip-components=1
  "${PKG_BUILD}/rust-std-${target}/install.sh" --prefix="${TOOLCHAIN}" --disable-ldconfig
}

makeinstall_host() {
  "${PKG_BUILD}/install.sh" --prefix="${TOOLCHAIN}" --disable-ldconfig
  case "${MACHINE_HARDWARE_NAME}" in
    "x86_64")
      _install_rust_std "aarch64-unknown-linux-gnu" \
        "c781b3ef4fefa5508fbe05820eddc95e46351d905a30921cc020febd9c596a2e"
      _install_rust_std "arm-unknown-linux-gnueabihf" \
        "d5db943974fe05306ae43d100b0b7f3540108b93ef52de670675ce966af8a0fd"
      ;;
    "aarch64")
      _install_rust_std "x86_64-unknown-linux-gnu" \
        "dd33653107c36e040082050d9e547e64dac5b456ba74069430d838c00c189a05"
      _install_rust_std "arm-unknown-linux-gnueabihf" \
        "d5db943974fe05306ae43d100b0b7f3540108b93ef52de670675ce966af8a0fd"
      ;;
    "arm")
      _install_rust_std "x86_64-unknown-linux-gnu" \
        "dd33653107c36e040082050d9e547e64dac5b456ba74069430d838c00c189a05"
      _install_rust_std "aarch64-unknown-linux-gnu" \
        "c781b3ef4fefa5508fbe05820eddc95e46351d905a30921cc020febd9c596a2e"
      ;;
  esac
}

