#!/bin/bash

report_file="system_report_$(date +"%Y%m%d_%H%M%S").txt"

get_external_ip() {
    curl -s http://ipecho.net/plain
}

{
    echo "Report generated on: $(date)"
    echo "Current User: $(whoami)"
    echo "Internal IP and Hostname: $(hostname -I) $(hostname)"
    echo "External IP Address: $(get_external_ip)"
    echo "Linux Distribution: $(lsb_release -d | cut -f 2)"
    echo "System Uptime: $(uptime -p)"
    echo "Disk Usage in /:"
    df -h / | awk 'NR==2{print "Used Space: " $3 " / Free Space: " $4}'
    echo "RAM Usage:"
    free -h | awk '/Mem/{print "Total: " $2 " / Free: " $4}'
    echo "CPU Information:"
    echo "Number of Cores: $(nproc)"
    echo "Frequency of Cores: $(lscpu | grep 'MHz' | awk '{print $3}') MHz"
} > "$report_file"

echo "Report generated: $report_file"
