#!/bin/bash

# System Hostname
echo "System Hostname: $(hostname)"

# Operating System
echo "Operating System: $(lsb_release -d | awk -F"\t" '{print $2}')"

# System uptime (how long the system has been online)
echo "System Uptime: $(uptime -p)"

# Linux Kernel Version
echo "Linux Kernel Version: $(uname -r)"

# General CPU Information
echo "CPU Information: $(lscpu | grep 'Model name')"

# Memory available and free
echo "Memory Information (Human-readable):"
free -h

# IP and MAC Address of all network interfaces
echo "Network Interface Information:"
for interface in $(ls /sys/class/net/); do
    echo -e "\nInterface: $interface"
    ip_address=$(ip addr show $interface | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1)
    mac_address=$(cat /sys/class/net/$interface/address)
    echo "IP Address: $ip_address"
    echo "MAC Address: $mac_address"
done

# Filesystem Utilization
echo "Filesystem Utilization (Human-readable):"
df -h

# Filesystem Types
echo "Filesystem Types:"
lsblk -f

# Last 5 lines of the general log file containing the word "error"
echo "Last 5 lines of the log file containing 'error':"
grep -i "error" /var/log/syslog | tail -n 5