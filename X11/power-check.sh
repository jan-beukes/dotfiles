#!/bin/sh

# Checks if laptop is plugged in an sets primary GPU and brightness

BATTERY_BRIGHTNESS=80

if [ -f "/sys/class/power_supply/ACAD/online" ]; then
    POWER_STATUS=$(cat "/sys/class/power_supply/ACAD/online")
elif [ -f "/sys/class/power_supply/AC/online" ]; then
    POWER_STATUS=$(cat "/sys/class/power_supply/AC/online")
else
    echo "AC power status not found. Assuming battery power."
fi

if [[ "$POWER_STATUS" -eq 1 ]]; then
    # AC
    /usr/local/bin/set-gpu on
    brightnessctl set "100%"
else
    # BATTERY
    /usr/local/bin/set-gpu off
    brightnessctl set "$BATTERY_BRIGHTNESS%"
fi
