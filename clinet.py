import socket
import subprocess
import sys
import os
import time as T
sock=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
port=62
buffer=2048
host=socket.gethostname()
addr=(host,port)
try:
	sock.connect(addr)
except socket.error as msg:
	print(" [X] "+str(msg))
T.sleep(2)
while True:
	
	cmd=input(str(addr[0])+' @ '+str(host)+' ~$ ')
	sock.send(cmd.encode("utf-8"))
	recev=sock.recv(buffer).decode('utf-8')
	
	if recev=="exit":
		T.sleep(2)
		sock.close()
		sys.exit()
	elif recev=="dir":
		print(os.getcwd())
	







