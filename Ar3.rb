::M = 5
i=0 
j=0
'''while i<=5 do 
    while j<=5 do
    print("\n\t"+M.to_s()+j.to_s())
    j+=1
    end
    i+=1
end
print("\n\n")
i=0
''''begin
    print("\t"+i.to_s())
    i+=1
end while(i<=5)'''
print("\n\n\n")
    for i,j in [1,2,3,4,5] do 
        print(i,j)
    end
def say_hello

yield
end
say_hello{puts"#{'hello'}"}
def test(&block)
yield
end
puts test {'HELLO'}
