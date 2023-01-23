#!/usr/bin/env bash

CURRENT_WIFI=$(nmcli -t -f NAME c show --active)
echo "w: ${CURRENT_WIFI}"
