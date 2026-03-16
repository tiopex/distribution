# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025 ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="sccache"
PKG_VERSION="v0.14.0"
PKG_LICENSE="Apache-2.0/MIT"
PKG_SITE="https://github.com/mozilla/sccache"
PKG_URL="https://github.com/mozilla/sccache/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="rustc-snapshot rust-std-snapshot cargo-snapshot"
PKG_LONGDESC="Shared Compilation Cache for Rust, C, and C++"

PKG_TOOLCHAIN="manual"

pre_configure_host() {
  "$(get_build_dir rustc-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig
  "$(get_build_dir rust-std-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig
  "$(get_build_dir cargo-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig

  export PATH="${PKG_BUILD}/rust-snapshot/bin:$PATH"

  export CARGO_HOME="${PKG_BUILD}/cargo_home"
  mkdir -p "${CARGO_HOME}"
  unset RUSTC_WRAPPER
}

make_host() {
  cd "${PKG_BUILD}"

  cargo build --release
}

makeinstall_host() {
  install -Dm755 "${PKG_BUILD}/.${RUST_HOST}/target/release/sccache" \
    "${TOOLCHAIN}/bin/sccache"
}