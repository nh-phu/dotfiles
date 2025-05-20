#!/bin/bash
# Save as ~/.config/hypr/scripts/toggle-layout.sh

current_layout=$(hyprctl getoption general:layout | grep -o 'dwindle\|master')

if [ "$current_layout" = "dwindle" ]; then
    hyprctl keyword general:layout master
else
    hyprctl keyword general:layout dwindle
fi
