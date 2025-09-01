#!/bin/bash

# Set recipient email
EMAIL="jeafive@gmail.com"
SUBJECT="Server Report - $(hostname)"

# Collect report in a variable
REPORT=$(cat <<EOF
===== Server Report =====

Hostname: $(hostname)
Uptime: $(uptime -p)
OS: $(lsb_release -d | cut -f2)

CPU Usage:
$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4"%"}')

Memory Usage:
$(free -m | awk '/Mem:/ {printf "Used: %dMB / %dMB (%.2f%%)\n", $3, $2, $3/$2 * 100.0}')

Disk Usage:
$(df -h --total | grep 'total' | awk '{print "Used: "$3" / "$2" ("$5")"}')

Top 5 Processes by CPU:
$(ps -eo pid,comm,%cpu --sort=-%cpu | head -6)

Top 5 Processes by Memory:
$(ps -eo pid,comm,%mem --sort=-%mem | head -6)

Logged in users:
$(who)

Failed login attempts:
$(grep "Failed password" /var/log/auth.log | wc -l)
EOF
)

# Send the report
echo "$REPORT" | mail -s "$SUBJECT" "$EMAIL"


