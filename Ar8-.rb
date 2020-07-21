require "socket"
'''
socket=Socket::new Socket::AF_INET,Socket::SOCK_STREAM
name="localhost"
port=62
pack_addr=Socket::pack_sockaddr_in(port,name)
socket.connect pack_addr
#socket.write("GET /HTTP/1.0 \n \n \n")
#result=socket.read()
#puts result
'''
require "shell"
socket=Socket.new :AF_INET,:SOCK_STREAM
pack_addr=Socket::pack_sockaddr_in(2000,'localhost')
socket.connect pack_addr
socket.puts "#{'OK'}"
puts " [i] Finished"
sleep 10
if socket.closed? == false
	socket.close
	puts " [i] closed"
end
print Shell::CommandProcessor.def_system_command('sys_echo','echo Hello')
Shell.install_system_commands
puts Shell.new.sys_echo