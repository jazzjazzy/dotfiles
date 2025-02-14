#!/bin/bash

# Detect active network interfaces
wifi_interface=$(ls /sys/class/net | grep -E 'wlp|wlan' | head -n 1)
eth_interface=$(ls /sys/class/net | grep -E 'enp|eth' | head -n 1)

# Resolve symlinks (handles virtual interfaces)
wifi_realpath=$(readlink -f /sys/class/net/$wifi_interface 2>/dev/null)
eth_realpath=$(readlink -f /sys/class/net/$eth_interface 2>/dev/null)

# Function to check if an interface is up
is_interface_up() {
    local iface=$1
    [[ -n "$iface" && -f "/sys/class/net/$iface/operstate" ]] && [[ "$(cat /sys/class/net/$iface/operstate 2>/dev/null)" == "up" ]]
}

# Check if connected to Wi-Fi
if is_interface_up "$wifi_interface"; then
    essid=$(iwgetid -r)
    strength=$(awk 'NR==3 {print $3}' /proc/net/wireless | sed 's/\..*//')
    ipaddr=$(ip -4 addr show "$wifi_interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

    echo "{\"text\":\"󰖩 ($strength%)\", \"tooltip\":\"Wi-Fi: $essid\nSignal: $strength%\nIP: $ipaddr\"}"

# Check if connected via Ethernet
elif is_interface_up "$eth_interface"; then
    ipaddr=$(ip -4 addr show "$eth_interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

    echo "{\"text\":\"󰛳 Eth\", \"tooltip\":\"Ethernet\nIP: $ipaddr\"}"

# No connection
else
    echo "{\"text\":\"󰌙 No Network\", \"tooltip\":\"No active network connection\"}"
fi
