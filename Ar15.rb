load"CM.rb"
cM=CM.new
'''matrix=cM::build(4)
for i in (0...matrix.length)
	for j in (0...matrix.length)
		matrix[i][j]=(rand()*15).to_i
	end
end'''
a=[[5,6,9,7],[1,2,3,4],[2,6,7,0],[3,4,8,0]]
CM::dis(a)
p r=CM::mm(a,[0,3])