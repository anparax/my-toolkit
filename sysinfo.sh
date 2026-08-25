#!/usr/bin/env bash
#
# sysinfo.sh - system health snapshot
# disk, memory and top 5 cpu usage processes

set -euo pipefail

echo "-:::- SYSTEM INFO -:::-"
echo "HOST: $(hostname)"
echo "UPTIME: $(uptime -p)"
echo

echo "-:::- DISK USAGE -:::-"
df -h --output=target,size,used,avail,pcent | grep -E '^/|Mounted'
echo

echo "-:::- MEMORY USAGE -:::-"
free -h
echo

echo "-:::- TOP 5 PROCESSES BY CPU -:::-"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
echo

echo "-:::- TOP 5 PROCESSES BY MEMORY -:::-"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
