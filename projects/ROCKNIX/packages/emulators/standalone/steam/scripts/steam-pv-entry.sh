#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

HELPER="/usr/bin/steamos-polkit-helpers/steamos-set-timezone"
[ -x "/run/host${HELPER}" ] && HELPER="/run/host${HELPER}"
for dest in \
    /storage/.local/share/Steam/steam-runtime-steamrt-arm64/var/tmp-*/usr/bin \
    /storage/games-internal/roms/steam/steam-runtime-steamrt-arm64/var/tmp-*/usr/bin
do
  [ -d "${dest}" ] || continue
  mkdir -p "${dest}/steamos-polkit-helpers"
  cp -p "${HELPER}" "${dest}/steamos-polkit-helpers/steamos-set-timezone"
done
exec "$@"
