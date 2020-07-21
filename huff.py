from heapq import *
from collections import Counter
from sys import argv
import math
def encode(freqs):
    heap = [[freq, [sym,""]] for sym, freq in freqs.items()]
    heapify(heap)
    while len(heap) > 1:
        lo = heappop(heap)
        hi = heappop(heap)
        for pair in lo[1:]:
            pair[1] = '0' + pair[1]
        for pair in hi[1:]:
            pair[1] = '1' + pair[1]
        heappush(heap, [lo[0] + hi[0]] + lo[1:] + hi[1:])
    return sorted(heappop(heap)[1:], key=lambda p: (p,len(p[-1])))
def entropy(freqs):
    freqs=[int(freq) for freq in freqs if freq!=None]
    probs=[freq/sum(freqs) for freq in freqs]
    Hx=[prob*math.log2(1.00/prob) for prob in probs if prob>0 and prob<1 and probs!=None]
    return round(sum(Hx),3),sorted(probs)
def avCL(lens,probs):
	return sum([lens[i]*probs[i]for i in range(0,len(probs))])
def main(txt):
    try:
        txt=[x for t in txt.split(",") for x in t.split(":")]
        b = {txt[i]: txt[i+1] for i in range(0, len(txt), 2)}
        e=entropy(b.values())
        lens=[]
        txt=""
        for i in b:
           txt+=i*int(b[i])    
        freqs=Counter(txt)
        huff = encode(freqs)
        print ("\n\tSymbol Freq HuffmanCode\n")
        for p in huff:
            print("\t%s\t%s\t%s" % (p[0], freqs[p[0]], p[1]),"\n")
            lens.append(len(p[1]))   
        print ("\n\tH(x)\tL(x)\tCE(x)\n")
        Lx=round(avCL(lens,e[1]),3)
        CE=round(e[0]/Lx,3)
        print("\t%s\t%s\t%s" % (e[0],Lx,CE),"\n")
    except:
        print("Oops!  That was Invalid")  
     

ex1="A:5,B:9,C:12,D:13,E:16,F:45"
ex2="B:3,E:4,P:2, :2,O:2,R:1,!:1"
inp=""
try:
    inp=input("input as (%s)"%ex1+":\t")
    main(inp) 
except:
   print("Oops!  That was Invalid") 