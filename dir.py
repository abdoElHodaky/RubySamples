import subprocess,sys,os,shlex
while True:
         comm=input("$->")
         #cmd=subprocess.Popen(shlex.split(comm),shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,stdin=subprocess.PIPE)
         result=os.popen(comm)
         #result=cmd.stderr.read()+cmd.stdout.read()
         #print(result.decode('utf-8'))
         print(result.read())
