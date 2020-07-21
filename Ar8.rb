require "socket"
'''
socket=Socket.new Socket::AF_INET,Socket::SOCK_STREAM
port=62
sock_addr=Socket::sockaddr_in(port,"localhost")
pack_addr=Socket::pack_sockaddr_in(port,"localhost")
socket.bind(pack_addr)
socket.listen(5)
client,addr=socket.accept()
data=client.recvfrom(1024)[0].chomp
print "\n\n\n"
sleep 5
print " [!] "+"#{Time.now} => "+addr.inspect() +"\n\n"
sleep 3
socket.close()
if(socket.closed? == true)
puts " [!] "+"Closed"
end
'''

socket=Socket::new :AF_INET,:SOCK_STREAM
pack_addr=Socket::pack_sockaddr_in(2000,'localhost')
socket.bind(pack_addr)
socket.listen(1)
ip=Socket::ip_address_list()[1].inspect().dump()
begin
	client,addr=socket.accept
	
	puts " [i]  Welcome " + ip +"Time:#{Time.now}" 
	data=client.recvfrom(1024)[0]
	sleep 5
	puts "current data: #{data}"
	sleep 10
	client.close
	if client.closed? == true
	puts " [i] closed"
	else
		puts " [i] still open "
		sleep 3 
		client.close
		puts " [i] closed"
	end
	rescue Exception => e
		print e.message
		retry
end