#!/bin/bash

# Set alert thresholds to 40%
CPU_LIMIT=80
MEM_LIMIT=80
DISK_LIMIT=80

# File where alerts will be saved
LOG_FILE="final_script.log"

# Run monitoring forever
while true; do
    # Get current date and time for alert messages
    DATE_TIME=$(date '+%Y-%m-%d %H:%M:%S')

    # Calculate CPU usage: 100% minus idle CPU
    CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
    CPU_USAGE=$((100 - CPU_IDLE))

    # Calculate memory usage percentage
    MEM_USED=$(free | grep Mem | awk '{print $3}')
    MEM_TOTAL=$(free | grep Mem | awk '{print $2}')
    MEM_USAGE=$(( 100 * MEM_USED / MEM_TOTAL ))

    # Get disk usage percentage for root partition
    DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

    # If CPU usage is over limit, alert and log it
    if [ $CPU_USAGE -gt $CPU_LIMIT ]; then
        echo "$DATE_TIME: CPU usage is high: $CPU_USAGE%" | tee -a $LOG_FILE
    fi

    # If memory usage is over limit, alert and log it
    if [ $MEM_USAGE -gt $MEM_LIMIT ]; then
        echo "$DATE_TIME: Memory usage is high: $MEM_USAGE%" | tee -a $LOG_FILE
    fi

    # If disk usage is over limit, alert and log it
    if [ $DISK_USAGE -gt $DISK_LIMIT ]; then
        echo "$DATE_TIME: Disk usage is high: $DISK_USAGE%" | tee -a $LOG_FILE
    fi

    # Wait 60 seconds before checking again
    sleep 60
done

