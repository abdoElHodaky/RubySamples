import socket
import sys
import os
import time as T
sock=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host=socket.gethostname()
port=62
buffer=2048
addr=(host,port)
try:
	sock.bind(addr)
except socket.error as msg:
	print(str(msg))
	sock.bind(addr)

sock.listen(10)
conn,addrress=sock.accept()

time=str(T.localtime()[3])+":"+str(T.localtime()[4])+":"+str(T.localtime()[5])

while True:
	command=input(addrress[0]+" @ "+socket.gethostname()+" > ")
	conn.send(command.encode('utf-8'))
	data=conn.recv(buffer).decode('utf-8')
	if data=='exit':
		conn.close()
		sock.close()
		sys.exit()
	print(data)
sock.close()	