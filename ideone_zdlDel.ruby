# your code goes here
def add n
 n+1
end
def mul n
 n*4
end
def div n
 n/n
end
def pow n
 n*n
end
arr=['div','mul','pow','add']
i=1
s=self.send(arr[0],3)
until i==arr.length-1
  puts s,"c.#{i}"

s=self.send(arr[i],self.send(arr[i+1],s))
  
  i+=1
  
end

