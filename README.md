# Mac Kill All

This script is designed to kill all non-essential processes on a macOS machine, allowing you to free up system resources by terminating processes that are not critical for the system's operation.

The script identifies essential processes and protects them from being terminated, while killing non-essential ones. It also provides user confirmation, logging, and error handling for safer execution.

## Features
- **User confirmation:** The script prompts the user for confirmation before proceeding to kill processes.
- **Logging:** All killed processes are logged to a file (`killed_processes.log`) for reference.
- **Error handling:** The script handles cases where processes cannot be killed (e.g., protected system processes).
- **Shell exclusion:** The script ensures that it does not terminate the shell session running the script.

## Prerequisites
- macOS system with `bash` shell.
- Execution permissions for the script.

## Usage
1. **Download or copy the script** to your local machine.

2. **Make the script executable:**

```bash
chmod +x kill_non_essential_processes.sh
```

3. Run the script:

```bash
./kill_non_essential_processes.sh
```

4. User confirmation: The script will prompt for confirmation before killing processes. Type `y` to proceed or `n` to abort.

5. Log file: Killed processes will be logged to `killed_processes.log` in the same directory.

## Customisations

- Essential Processes: You can customize the list of essential processes by editing the `essential_processes` array in the script. Add or remove process names as needed:

```bash
essential_processes=(
    "launchd"
    "WindowServer"
    "kernel_task"
    ...
)
```
- Current Shell Exclusion: The script automatically excludes the current shell session (`bash`, `zsh`, `sh`) from being terminated.

## Warning

This script kills processes forcefully using `kill -9`. Be cautious as terminating the wrong process may lead to system instability or loss of unsaved work. Make sure to review the essential processes list and run the script with care.

## License

This script is provided "as is" and is licensed under the GPL 3.0 License - see the [LICENSE](LICENSE) file for details, without warranty of any kind. Use at your own risk.
