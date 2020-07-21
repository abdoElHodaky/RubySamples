import socket
import sys
import os
import time as T
sock=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host=socket.gethostname()
port=62
buffer=2048
addr=(host,port)

sock.bind(addr)

sock.listen(10)


time=str(T.localtime()[3])+":"+str(T.localtime()[4])+":"+str(T.localtime()[5])
conn,addr=sock.accept()
print("Connected By:- "+ str(addr[0])+":"+str(addr[1])+" [T: "+time+"]")
while True:
	
	data=conn.recv(buffer)
	cmd=data.decode('utf-8')
	
	if cmd=="exit":
		conn.close()
		sys.exit()

	else:conn.send(cmd.encode('utf-8'))

