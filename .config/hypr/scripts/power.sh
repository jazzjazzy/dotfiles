#!/bin/bash

# let get the swaylock command from the hyprland.conf
# so we don't have to remember it twice
HYPRLAND_CONFIG=~/.config/hypr/hyprland.conf
lock_command=$(grep -Po '(?<=\$lockscreen = ).*' "$HYPRLAND_CONFIG")

case "$1" in
    lock)
        eval "$lock_command"
        ;;
    hibernate)
        systemctl hibernate
        ;;
    exit)
        hyprctl dispatch exit
        ;;
    shutdown)
        systemctl poweroff
        ;;
    suspend)
        systemctl suspend
        ;;
    reboot)
        systemctl reboot
        ;;
    *)
        echo "Usage: $0 {lock|hibernate|exit|shutdown|suspend|reboot}"
        exit 1
        ;;
esac
