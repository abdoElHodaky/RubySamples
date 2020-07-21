'''$R=1 # global variable
class Welcome
    @@X=0 ##@@variable instance member
    @@Y=0
    def Add(x,y)
        @@X=x
        @@Y=y
        z=x+y+$R+1
        #print("#@@X","#@@Y")
        return z 
    end
    

end
W=Welcome.new()
print(W.Add(5,5))'''
#print(3+5)
#global varible ($)+ variable name
A={"1"=>"A","2"=>"B","3"=>"D","4"=>"O"}
A.each do |i,j|'''##loop on dictionary(hash) using var.each ==> array ,hash,etc'''
    puts i+"=>"+j
end
'''#syntax of  each (var.each do | subvar1 only or subvar1,subvar2,subvarn|)'''
print "\n"
(100..200).each do |i|
    print i,"\t"
end
print "\n"
'''syntax of range (start(...)end)
syntax of sequence (start(..)end)'''


