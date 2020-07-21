begin
for i in 1..8
    if i<=2
        #puts(i)
        redo
        
    end
end    
rescue    

end

for i in 1..8
   
    #retry if i > 2 
    #puts(i)
    
end

def test
    yield 
    puts("Hello")
end
test{"Hello"}
