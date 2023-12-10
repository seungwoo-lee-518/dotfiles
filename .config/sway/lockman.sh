#!/usr/bin/env bash

swayidle \
  timeout 10 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' &

swaylock -c 550000
kill %%
