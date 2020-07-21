'''
open("w.txt","r+") { 
	|handle|
	handle.write("Abdo")
	handle.close()
 }

open("w.txt","a") {
 |handle|
handle.write(" el-Hodaky ")

handle.close()
  }

  open("w.txt","r"){
  	|handle|
print(handle.readlines())
  }
'''
#time= Time.now
require "net/http" 
url=URI("http://abdo.com/video.js")
f=Net::HTTP::get(url)
open("A.js", "w") { 
	|io|
	io.write(f)
	  }
require "net/ftp"
ftp=Net::FTP.new("abdo.com")
puts ftp.login("abdo","279348")? "Access":"Access Denied"
#puts ftp.list
begin
ftp.get "gears.svg"
ftp.put "Tux.svg"
rescue Exception.new
end
#ftp.closed?
if ftp.closed? ==true
	ftp.quit()
else
	puts"Still open"
	ftp.close()
end
