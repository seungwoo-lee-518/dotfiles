
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  export MOZ_ENABLE_WAYLAND=1
  exec sway
fi