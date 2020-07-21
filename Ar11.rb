load  "CM.rb"
A=[1,0,3,8,-1,5,-5,-15];#comparision between (i,i+1)
array=[3,1,4,2,5];
array2=[10,1,2,5,1];
def asrt (array,method,offset=0)
	if method=='asc'
		return ascsrt(array,offset)
	end
	if method=='des'
		return dessrt(array,offset)
	end
end
def ascsrt array,offset
i=offset
while (i<array.length)
	j=i+1
	while (j<array.length)
		if array[i]>array[j]
				tmp=array[i]#'''Swap bigger to smaller'''
				array[i]=array[j]
				array[j]=tmp
		 end 
		 if array[j]<array[i]
				tmp=array[j]
				array[j]=array[i]
				array[i]=tmp
			end
	j=j+1
	end
i=i+1
end
return array#array.each { |e| puts"\n",e  }
end
def dessrt array,offset
	i=offset;
	while i<array.length
		j=i+1
		while j<array.length
			if array[i]<array[j]#Swap smaller to bigger'''
				tmp=array[i]
				array[i]=array[j]
				array[j]=tmp
				
			end
			if array[j]>array[i]
				tmp=array[j]
				array[j]=array[i]
				array[i]=tmp
				
			end

		j=j+1	
		end
	i=i+1	
	end
	
return array#array.each { |e| puts"\n",e  }
end
def srt (*args)
method=args[args.length-1]	
method=method=='asc'? true:false
if method
	args[0]=ascsrt(args[0])
	args[1]=ascsrt(args[1])
	else
	args[0]=dessrt(args[0])
	args[1]=dessrt(args[1])
end
return args	
end
def  csrt(*args) #sorting two array at the same time
i=0
j=0
array=args[0]
array2=args[1]
#array3=args[2]
while i<array.length
	j=i
		while j<array.length
			if (array[i] > array[j])
				temp=array[i]
				array[i]=array[j]
				array[j]=temp
				
				tmp=array2[i]
				array2[i]=array2[j]
				array2[j]=tmp

				#temp=array3[i]
				#array3[i]=array3[j]
				#array3[j]=temp
			end	
			if (array[j] < array[i])
				temp=array[j]
				array[j]=array[i]
				array[i]=temp
				
				tmp=array2[j]
				array2[j]=array2[i]
				array2[i]=tmp

				#temp=array3[j]
				#array3[j]=array3[i]
				#array3[i]=temp
			end
		j=j+1	
		end
	
	i=i+1
end
return array,array2
end
def ascisrt(array,method=0)
	i=0
	bytes=[]
	while i<array.length
		array[i].each_byte { |byte|
			bytes[i]=byte
		  }
		  
		i+=1
	end	
	i=0
	while i<array.length
		j=i+1
		while j<array.length
			if method==0
				if bytes[i]>bytes[j]
					tmp=bytes[i]
					bytes[i]=bytes[j]
					bytes[j]=tmp
				end
			else
				if bytes[i]<bytes[j]
					tmp=bytes[i]
					bytes[i]=bytes[j]
					bytes[j]=tmp
				end
			end
			j+=1
		end
		array[i]=bytes[i].chr
		i+=1
	end
	return array
end
def IS(array,offset=0)
	i=offset
	current=[]
	while i<array.length
		current=array[i]
		j=i-1
		while array[j]>current && j>=0
			
			array[j+1]=array[j]
				j-=1
		end
		array[j+1]=current
		i+=1
	end
	return array
end
def _IS(array,offset=0)
	i=array.length-2
	current=[]
	while i>=0
		current=array[i]
		j=i+1
		while  j<array.length-1 &&array[j]>current
			array[j-1]=array[j]
				j+=1
		end
		array[j-1]=current
		i-=1
	end
	return array
end
def SS(array,offset=1)
	i=offset
	min=0
	while i<array.length
		min=i
		j=i+1
		while j<array.length
			if array[j]>array[min]
				min=j
			end
				tmp=array[min]
				array[min]=array[i]
				array[i]=tmp
				j+=1
		end
		i+=1
	end
	return array
end

def seqSearch array,word
	i=0
	index=-1
	while i<array.length
		if word==array[i]
			index=i
		end
		i+=1
	end
	return index
end
def binarySearch (array,word,offset,length)
	index=-1
	middle=((offset+length)/2).to_i()
	if word==array[middle]
		index=middle
		elsif word>array[middle]
			index=binarySearch(array,word,(middle+1),length)
		elsif word<array[middle]
			index=binarySearch(array,word,offset,(middle-1))
	end
	return index
end
def intersection matrix,all=false,i=0,j=0
	def allintersec matrix
			_intersection={}
			for k in (0...(matrix.length))
				row=rows(matrix,k)
				for l in (0...(matrix[k].length))
					column=columns(matrix,l)
					if row[k]==column[l]
						_intersection[k]=column[l]
					end
				end
			end
			if _intersection!=nil
					return _intersection
			end
	end
	if all==true
		return allintersec(matrix)
	else
			row=rows(matrix,i)
			column=columns(matrix,j)
			_intersection=""
			for k in (0...(matrix.length))
				if row[k]==column[k]
				_intersection=row[k]||column[k]	
				end
			end	
			if (_intersection!=nil)||(_intersection!='')
				return _intersection
				else
				return false
			end
	end
end
def pintersec matrix,point,point2
	i=point2[1]-point[0]
	j=point2[1]-point[1]
	return intersection(matrix,false,i%matrix.length,j%matrix[0].length)	
end


