#!/bin/bash
title=$(hyprctl activewindow -j | jq -r '.title // "No Active Window"')

if [ ${#title} -gt 80 ]; then
    echo "${title:0:80}..."
else
    echo "$title"
fi