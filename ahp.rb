#AHP
load "CM.rb"
prios={"S"=>"5","Eq"=>"1","M"=>"3","VS"=>"7","Ex"=>"9"}
priosI={"Eq,M"=>"2","M,S"=>"4","S,VS"=>"6","VS,Ex"=>"8"}
m=CM::new()
print "Enter Cirteria:\n"
criteria=gets.split(',')#["Price","Storage","Camera","Look"]
matrix=m::build(criteria.length)
inputs="S:Price,Storage;\
I:Price,Camera|M,S\
;VS:Price,Look;\
M:Storage,Look;M:Camera,Look;\
I:Camera,Storage|Eq,M"
#inputs="S:Price,Storage;Ex:Look,Storage"
#inputs=gets
sperators=[";","|"]
count=(sperators.map { |e| inputs.include? e  })
conditions=(inputs.split(sperators[count.index(true)])).map { |e| e.split(":")  }
for i,j in conditions
    if j.include? "|"
        conditionsI=j.split("|")
        intermidates=conditionsI[0].split(",")
        matrix[criteria.index(intermidates[0])][criteria.index(intermidates[1])]=priosI[conditionsI[1]].to_i
    else
        index=(j.split(",")).map { |e| criteria.index(e)  }
        matrix[index[0]][index[1]]=prios[i].to_i
    end
end
#matrix=#[j,i]=[i,j]**-1 unless i==j#
#tmpMatrix
#sum of col
#each col / sum of col
#cirteriaW=sum of rows/no of rows
#cirteriaW*rows then choose greater
for i in (0...matrix.length)
	for j in (0...matrix[0].length)
	    matrix[j][i]=(matrix[i][j]**(-1)).round(2) if matrix[i][j]!=nil
	    if i==j
	        matrix[i][j]=1
	    end
	end
end
mpMatrix=matrix
tmpMatrix2=matrix
for i in (0...tmpMatrix[0].length)
	cols=CM::getcols(tmpMatrix,i)
    sum=(cols.map(&:to_f).reduce(0,:+))
    _cols=cols.map{
        |e| e/=sum 
        e.round(4)
		}
    m::editcols(tmpMatrix,i,_cols)
end
cirteriaW=[]
for i in (0...tmpMatrix.length)
	rows=CM::getrows(tmpMatrix,i)
	cirteriaW.push ((rows.reduce(0,:+))/rows.length).round(4)
end
for i in (0...tmpMatrix2.length)
	rows=CM::getrows(tmpMatrix2,i)
	rows=rows.map do |e|
	    e*=cirteriaW[rows.index(e)]
	    e=e.round(7)
	end
	tmpMatrix2[i]=(rows.reduce(0,:+)).round(7)
end
cirteriaW=m::AtoMatrix(tmpMatrix2,Math.sqrt(tmpMatrix2.length).ceil,Math.sqrt(tmpMatrix2.length).ceil)
res=CM::>(cirteriaW).map do |e|
    criteria.at(tmpMatrix2.index(e))
end
print "\e[6;94;35m CirteriaUsed\e[0m:\t\e[5;93;34m#{res.join(",")}\e[0m\n"