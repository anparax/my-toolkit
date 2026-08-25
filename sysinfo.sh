#!/usr/bin/env bash
#
# sysinfo.sh - system health snapshot
# disk, memory and top 5 cpu usage processes

set -euo pipefail

echo "-:::- SYSTEM HEALTH REPORT -:::-"
echo "> HOST: $(hostname)"
echo "> UPTIME: $(uptime -p)"
echo "> CPU LOAD: $(uptime | awk -F'load average:' '{print $2}')"
echo "> MEMORY USAGE: $(free -h | awk 'NR==2 {print $3 "/" $2}')"
echo "> DISK USAGE: $(df -h / | awk 'NR==2 {print $5}')"
echo "> NETWORK STATUS: $(ping -c 1 8.8.8.8 &>/dev/null && echo "Connected" || echo "No connection")"
echo

echo "-:::- TOP 5 PROCESSES BY CPU -:::-"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
echo

echo "-:::- TOP 5 PROCESSES BY MEMORY -:::-"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
