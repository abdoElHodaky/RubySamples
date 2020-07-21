# cook your dish here
import math
from matplotlib import pyplot
def entropy(freqs):
    freqs=[int(freq) for freq in freqs if freq!=None]
    probs=[freq/sum(freqs) for freq in freqs]
    Hx=[prob*math.log2(1.00/prob) for prob in probs if prob>0 and prob<1 and probs!=None]
    return round(sum(Hx),3),sorted(probs)
def getrows(m,r=0):
	return [m[r][i] for i in range(len(m))]
def getcols(m,r=0):
	return [m[i][r] for i in range(len(m))]		
def mard(m):
	rows_total=[]
	cols_total=[]
	for i in range(len(m)):
		rows,cols=[int(k) for k in getrows(m,i)],[int(j) for j in getcols(m,i)]
		rows_total.append(sum(rows))
		cols_total.append(sum(cols))
	if sum(rows_total)==sum(cols_total):
		cols_total.append(sum(cols_total))
		return sorted((rows_total,cols_total))
def toArray(m):
    d=[value for i in m for value in i]
    return d
def main():
	try:
		matrix=input('input freqs matrix as (r1:value1,value2|r2:value1,value2): ')
		rows=[]
		matrix=[j for i in matrix.split("|") for j in i.split(":")]
		b = {matrix[i]: matrix[i+1].split(",") for i in range(0, len(matrix), 2)}
		rows=sorted(b.keys())
		m=[b[rows[i]]for i in range(len(rows))]#|[[12,15,2,0],[4,21,10,0],[0,10,21,4],[0,2,15,12]]
		t=mard(m)
		ex,ey=entropy(t[0]),entropy(t[1])
		exy=entropy(toArray(m))
		Ixy=round(ex[0]+ey[0]-exy[0],3)
		Hn=round(ey[0]-Ixy,3)
		for i in range(0,len(m)):
			rows=getrows(m,i)
			rows.append(str(t[1][i]))
			m[i]=rows
		m.append([str(i)for i in list(t)[0]])
		rows=["y"+str(i+1) for i in range(len(m)-1)]
		cols=["x"+str(i+1) for i in range(len(m)-1)]
		rows.append('mx')
		cols.append('my')	
		pyplot.axis('off')
		pyplot.table(cellText=m,loc="center",rowLoc='left',colLoc='left',colLabels=cols,rowLabels=rows)
		pyplot.title("H(x):%s  H(y):%s\n H(x,y):%s  I(x,y):%s  H(n):%s"%(ex[0],ey[0],exy[0],Ixy,Hn))
		pyplot.show()
	except:
		print("Invaild")
main()