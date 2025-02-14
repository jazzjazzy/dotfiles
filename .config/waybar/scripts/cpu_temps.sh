#!/bin/bash

# Get all CPU temperatures, suppressing error messages
temps=$(sensors 2>/dev/null | grep -E 'Core|Tctl' | awk '{print $1, $2, $3}')

# Extract highest temperature for display (removing the '+' sign)
highest_temp=$(echo "$temps" | awk '{print $3}' | sed 's/+//g' | sort -nr | head -n 1)

# Format tooltip: Ensure proper JSON escaping
tooltip=$(echo "$temps" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/\"/\\"/g')

# Output JSON for Waybar
echo "{\"text\":\" $highest_temp°C\",\"tooltip\":\"$tooltip\"}"
