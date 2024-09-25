#!/bin/bash

# List of essential processes
essential_processes=(
    "launchd"
    "WindowServer"
    "kernel_task"
    "kextd"
    "UserEventAgent"
    "SystemUIServer"
    "loginwindow"
    "cfprefsd"
    "dock"
    "Finder"
    "Spotlight"
    "coreaudiod"
    "hidd"
    "bash"        # Keep the shell process alive
    "zsh"         # If using zsh
    "sh"          # Generic shell
)

# Get the current shell PID
current_shell_pid=$$

# Log file to store killed processes
logfile="killed_processes.log"
echo "Killed processes log - $(date)" > "$logfile"

# Function to check if a process is essential
is_essential() {
    for essential in "${essential_processes[@]}"; do
        if [[ $1 == *"$essential"* ]]; then
            return 0 # True, it's essential
        fi
    done
    return 1 # False, it's not essential
}

# Confirm with the user
read -p "Are you sure you want to kill all non-essential processes? (y/n): " confirm
if [[ $confirm != "y" ]]; then
    echo "Aborting script."
    exit 0
fi

# Get the list of all running processes (excluding the current script)
all_processes=$(ps -axo pid,comm | grep -v "$current_shell_pid")

# Loop through all running processes and kill non-essential ones
while read -r process; do
    pid=$(echo $process | awk '{print $1}')
    process_name=$(echo $process | awk '{print $2}')

    if ! is_essential "$process_name"; then
        echo "Killing process: $process_name (PID: $pid)"
        echo "$process_name (PID: $pid)" >> "$logfile"
        if ! kill -9 "$pid" 2>/dev/null; then
            echo "Failed to kill $process_name (PID: $pid) or process is protected."
        fi
    fi
done <<< "$all_processes"

echo "Non-essential processes have been killed. Check the log at $logfile."
