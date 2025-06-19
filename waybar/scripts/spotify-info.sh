#!/bin/bash

player="spotify_player"

status=$(playerctl --player=$player status 2>/dev/null)

if [[ $status == "Playing" || $status == "Paused" ]]; then
    artist=$(playerctl --player=$player metadata artist)
    title=$(playerctl --player=$player metadata title)
    echo "🎵$title"
else
    echo ""
fi
