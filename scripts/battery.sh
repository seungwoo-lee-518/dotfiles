#!/usr/bin/env bash

BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

if [[ $BATTERY_STATUS == "Charging"  ]]; then
  echo -e "C: ${BATTERY_CAPACITY}%"
else
  echo "${BATTERY_CAPACITY}%"
fi