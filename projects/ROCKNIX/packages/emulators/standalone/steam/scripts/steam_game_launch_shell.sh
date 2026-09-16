#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

CLIENT="/storage/.local/share/Steam/steam-runtime-steamrt-arm64/pressure-vessel/bin/steam-runtime-launch-client"

if [ "${1:-}" = "-c" ]; then
  set -- /bin/sh "$@"
else
  set -- /bin/sh -c "$1"
fi

exec "${CLIENT}" \
  --bus-name=com.steampowered.PressureVessel.ROCKNIXHost \
  --directory="${PWD}" \
  --pass-env-matching='*' \
  --inherit-env=PATH \
  --inherit-env=LD_LIBRARY_PATH \
  --inherit-env-matching='XDG_*' \
  --inherit-env-matching='PRESSURE_VESSEL*' \
  --unset-env=WAYLAND_DISPLAY \
  --unset-env=container \
  -- "$@"
