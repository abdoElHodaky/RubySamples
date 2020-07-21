load "Ar11.rb"
array=[]
print"Enter chars: 	"
array=gets.chomp().split("\t")
i=0
while i<array.length
	array[i]=array[i].to_i()
	i+=1
end
i=0
#print _IS(array),"\n"
#print SS(array),"\n"
print binarySearch(array,1,0,array.length),"\n"
print seqSearch(array,1)