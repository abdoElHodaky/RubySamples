load "CM.rb"
print "Please an  matrix:\n"
matrix=gets.chomp.split(",").map { |e| e.to_i  }
print "Please enter Prices:\n"
#[8,7,7,7,8]
prices=gets.chomp.split(",").map { |e| e.to_f  }
m=CM::new()
#matrix=[9,13,10,14,7,13,10,11,9,13,11,8,14,6,17,21,7,9,5,16]
matrix=m::fill_matrix(matrix)
tmpmatrix=matrix
print "------------Matrix----------------\n"
CM::dis(tmpmatrix)
print "------------Matrix----------------\n"
def neib(cmatrix,itemsC,usemin=false)
    max=[]
    r=[]
    matrix=cmatrix
	items=CM::getcols(matrix,itemsC)
    _cols=[]
    index=0
    items.each do |item|
        index=[items.index(item),itemsC]
        _cols=CM::getcols(matrix,index[1]-1)
        if index[0]==_cols.length-1
            max= _cols.slice(index[0]-1,index[0]+1)
        elsif index[0]==0
            max= _cols.slice(index[0],2)
        else
            max= _cols.slice(index[0]-1,index[0]+2)
        end
		addativeItem=(usemin==true)? (max.min):(max.max)
        r.push addativeItem+item
    end
    CM::editcols(matrix,itemsC-1,r)
	return usemin
end
i=tmpmatrix[0].length-1
until i==0
    neib(tmpmatrix,i)
    i-=1
end
res=tmpmatrix
puts
puts
print "------------PricingD----------------\n"
CM::dis(res)
print "------------PricingD----------------\n"
puts
puts
coloredItems=CM::>(res,false):
print "------------MAX----------------\n"
for i in (0...coloredItems.length)
    cI=coloredItems[i]
    index=m::getIndex(cI,res)
    '''if index.length>2
        index.each { |e|
            index= e unless e[1]!=i
        }
        item=res[index[0]][index[1]] unless index[1]!=i and (index[0]==nil or index[1]==nil)
        itemC="\e[7;95;34m#{item}\e[0m"
        
    else
        item=res[index[0]][index[1]] unless index[1]!=i and (index[0]==nil or index[1]==nil)
        itemC="\e[8;94;36m#{item}\e[0m"
    end'''
    item=res[index[0]][index[1]] unless index[1]!=i and (index[0]==nil or index[1]==nil)
    itemC="\e[7;96;36m#{item}\e[0m"
    res[index[0]][index[1]]=itemC
end
CM::dis(res)
puts
print "Year:\t\e[6;98;35m#{((1..res.length)).to_a().join("\t")}\e[0m\n"
print "Price:\t\e[7;99;34m#{prices.join("\t")}\e[0m\n"
print "Profit:\t\e[8;100;33m#{coloredItems.join("\t")}\e[0m\n"
print "------------MAX----------------\n"