load "CM.rb"
print("Enter PayoffArray And Probs:\t\n")
inputs=gets.split("|")
file,probs=[],[]
inputs[0].split(",").map { |e| file.push e.to_i  };inputs[1].split(",").map { |e| probs.push e.to_f  }
m=CM::new()
#matrix=[50,0,-8,-10,12,64,-15,66,12],probs=[.25,.5,.25]
matrix=m::fill_matrix(file)
def regret(m,usemin=true)
    max=CM::>(m::getMatrix,false)
    min=CM::<(m::getMatrix,false)
    def subFromArray arr,num
    	res=[]
    	arr.each do |i|
    		diff=i-num
    		diff=diff<0?(diff*-1): diff
    		res.push(diff)
    	end
    	return res
    end
    cols=[]
    _cols=[]
    res=[]
    for i in (0...max.length)
        cols=CM::getcols(m::getMatrix,m::getIndex(max[i])[1])
           	if usemin
           		_cols=subFromArray(cols,min[i])	
           	else
           		_cols=subFromArray(cols,max[i])
           	end
        res.push _cols
    end
    res=m::transpose(res)
    CM::dis(res)
    puts
    return !usemin ? CM::>(res).min : CM::>(res).min
end
CM::dis(m::getMatrix)
print("-----------------Optimistic-------------------\n")
res=CM::>(m::getMatrix).max,CM::<(m::getMatrix).min
print "\e[8;99;30mOProfit:\e[0m\e[9;97;36m#{res[0]}\e[0m","\t","\e[8;99;30mOCost:\e[0m\e[9;97;37m#{res[1]}\e[0m\n"
print("-----------------Optimistic-------------------\n")
print("-----------------Pessimistic-------------------\n")
res=CM::>(m::getMatrix).min,CM::<(m::getMatrix).max
print "\e[8;99;30mOProfit:\e[0m\e[9;97;36m#{res[0]}\e[0m","\t","\e[8;99;30mOCost:\e[0m\e[9;97;37m#{res[1]}\e[0m\n"
print("-----------------Pessimistic-------------------\n")
print("-----------------Regret-------------------\n")
resp=regret(m,false)
resc=regret(m,true)
print "RProfit:\e[9;97;36m#{resp}\e[0m","\t","RCost:\e[9;97;37m#{resc}\e[0m\n"
print("-----------------Regret-------------------\n")
def EVPI(m,probs,usemin=true)
	cols=[];res=[];max=[]
	def sumArray(arr)
	    sum=0
	    arr.each do |e|
	        sum+=e
	    end
	    return sum
	end
	for i in (0...probs.length)
        cols=CM::getcols(m::getMatrix,i)
        res.push  CM::mulS(m::getMatrix,probs[i],true,nil,i)
		pushedItem=(usemin==true)? (cols.min):(cols.max)
        max.push pushedItem		
    end
    res=m::transpose(res)
    for i in (0...res.length)
        res[i]=sumArray(res[i]).round(2)
    end
        equaledItem=(usemin==true)? (res.min):(res.max)
		ev=equaledItem
		sum=0
		max.each do |m|
			sum+=m*(probs[max.index(m)]).round(2)
		end
		return (sum-ev).round(2),ev.round(2)
end
print("-----------------EVPI-------------------\n")
res=EVPI(m,probs,false),EVPI(m,probs,true)
print "\e[8;99;30mEVPI:\e[0m\e[9;97;36m#{res[0]}\e[0m","\t","\e[8;99;30mEV:\e[0m\e[9;97;37m#{res[1]}\e[0m\n"
print("-----------------EVPI-------------------\n")