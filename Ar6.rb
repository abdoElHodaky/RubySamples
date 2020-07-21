# cook your code here
'''
str=String.new("Abdo")#decalre new instance of String
print(str.upcase()+"\n")#upper case
print(str.downcase()+"\n")#lower case
print((str.length).to_s()+"\n")
str.concat(" El-Hodaky \n ")#add to string
print(str)
str.chomp()#delete slashes ($)
str.chop()#delete last char of string
print(str.capitalize!())#convert all char to uppercase
print(str.center(2)+"\n")#centeralize string
puts(str.crypt("A.Z /or/ 0.9")+"\n")#get hash of string with salt arg
puts str.dump()
#print(str.split(" "))

for i in str.split(" ")
puts(i)

end
str.split(" ").each do |i|
if (i=="Abdo")
      
    puts(i)
 end

end
puts(str.empty?)#check empty or not
puts(str.eql?("Abdo"))#eauality
puts(str.gsub("\n","|"))#replacement
puts("\n\n\n")
putc(02345)#args ::Octal
putc(2345)#args ::Decimal
putc(11011011)#args ::Binary
putc(0x2345)#args ::hexDecimal
puts("\n\n\n")
#get ::get input
print "Enter name"
name=gets
puts name
str[0]="3"#replace one char
puts(str[0,4])#return a substring
puts(str.hash)#hash of String
puts(str.hex)
puts(str.index("o",0))
puts(str.inspect())
puts(str.ljust(str.length+1,"|"))#arg0 greater than String.length #arg1 padding string
'''
'''
Array
'''
A=Array.new([1,3,5,7,9,11])
B=Array.new([2,4,6,8,10,12])
C=Array.new(A|B)
odd=C.slice(0,C.length-6)
odd.insert(odd.length,13)
odd.push 15
'''
odd.delete_at(odd.length-1)
odd.insert(odd.length,13)'''

even=C.slice(A.length,B.length)
even.push(14).push(16).unshift(18).shift
print "\n"+"odd  : #{odd}" 
print " \n"
print "even : #{even}"+"\n"
Table_mutliplication=Array.new(10) {
 |i|
 i*=i

  }
  #print "Table_mutliplication:#{Table_mutliplication}"+"\n\n\n"
  Table_mutliplication2=Array.new(10) { |i|
i**=i
    }
    #print "Table_mutliplication2:#{Table_mutliplication2}"
 Table_mutliplication3=Table_mutliplication<<Table_mutliplication2
hash={}
#print Table_mutliplication3

i=0
while i<Table_mutliplication2.length
	hash[i]=Table_mutliplication2[i]
	i+=1
end
print "\n\n"
puts "hash:"+"#{hash}"
print "\n\n\n"
'''odd.map(!){
	|i|
	print i
}'''#replace value returned by block
puts Table_mutliplication3.empty?					  #check array if empty 
puts Table_mutliplication3.eql?Table_mutliplication2  #check two arrays is equals
puts Table_mutliplication2.hash
Table_mutliplication3.fetch(Table_mutliplication3.length){
|index|
puts index
}#args ::index
print "\n\n\n\n\n"
puts Table_mutliplication3.flatten.frozen?
puts Table_mutliplication3.include?(9)
puts Table_mutliplication3.inspect.dump
#print Table_mutliplication3.join(',')
#puts Table_mutliplication3.rassoc 0
print hash.to_a()
###########################''''''''''''''''''