a=[8, 4, 6, 2, 6, 4, 7, 9, 5, 8]
a.sort()
print(a)
def duplicate(a):
    d=0
    i=0
    f=False
    while i<len(a)-1:
        if a[i]==a[i+1]:
            f=True
            d=a[i]   
        i+=1
    if f:
        return d
    else:
        return -1
print(duplicate(a))        