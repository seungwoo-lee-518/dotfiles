#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi