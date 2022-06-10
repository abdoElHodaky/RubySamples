a=[3,5,7,8,9,11,20,6,15,30,1,2,0,-7,-9,4,50,12,13,14]

t=12

res=a.map {|e|
  d=a.shift()
  a.select {|e| e <d}.length
}
r=[]
'''a.map {|e|

  ind=a.index(e)
  nexind=ind+1
  k=a[nexind]
  k=(k.nil?)?0:k
  a.select {|e| r<<[a.index(e),a.index(k)] if e+k==t}
}'''
p res


 
