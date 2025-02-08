#!/bin/bash
#     _         _        _            _     
#    / \  _   _| |_ ___ | | ___   ___| | __ 
#   / _ \| | | | __/ _ \| |/ _ \ / __| |/ / 
#  / ___ \ |_| | || (_) | | (_) | (__|   <  
# /_/   \_\__,_|\__\___/|_|\___/ \___|_|\_\ 
#                                           
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

pkill xautolock

HYPRLAND_CONFIG=~/.config/hypr/hyprland.conf
lock_command=$(grep -Po '(?<=\$lockscreen = ).*' "$HYPRLAND_CONFIG")

xautolock -time 10 -locker "$lock_command" -notify 30 -notifier "notify-send 'Screen will be locked soon.' 'Locking screen in 30 seconds'"
