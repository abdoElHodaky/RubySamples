load "CM.rb"
##Keser-Chiper
def check letter,reverse=false,letters=false
	i=0
	output={}
	range=(0...26).to_a
	range2=('a'..'z').to_a
	if reverse==true
			while i<range.length
			output[i]=range2[i]
			i+=1
			end
	else
			while i<range2.length
				output[range2[i]]=range[i]
				i+=1
			end
	end
	if letters==true
		return range2.map { |e| e[rand(0)]  }.join
	end
	if letter==""
			return output
		end
	return output[letter]
end
def ascii letter,reverse=false
	i=0
	output={}
	range=(97..122).to_a
	range2=('a'..'z').to_a
	if reverse==true
		while i<range.length
		output[range[i]]=range2[i]
		i+=1
		end	
	else	
		while i<range2.length
		output[range2[i]]=range[i]
		i+=1
		end	
	end
		if letter==""
			return output
		end

	return output[letter]
end
def generate_str (word,length,sub=false,rand=false,all=false)
	str=check('',false,true)
	if rand==true
			return (0...(length)).map { |e|
				if all==true
					str=('0'..'z').to_a
					_str=str[rand(str.length)]
				else
					_str=str[rand(str.length)]
				end
			if sub==true
				if _str!=word[e]
					_str
				end
			else
				_str
			end
			  }.join
	else
			return(0...(length)).map {|e|
			 _str=str[e]
				}.join
	end
	
end	
def gpass length,all=false
	pass=[]
	for i in (0..length)
		for n in (0...26)
			for i in (0...(26*n))
				pass.push generate_str('',length,false,true,all)
			end
		end
	end
	return pass
	#pass.uniq
end
def generate_num offset,endset
	rand=0
	while true
		return rand=rand(endset)
	end
	if rand==0
		return generate_num(rand,endset)
	end
end
def _genNum offset,endset,n
	_rand=[]
	for i in (0...n)
		r=generate_num(offset,endset)
		if ((r!=generate_num(offset,endset))&&(r!=0))
			_rand.push r
		else
			break
		end
	end
	if _rand.length==n
		return _rand.uniq
	else
		return _genNum(offset,endset,n)
	end
end
def KE word,shiftkey=3
	k=shiftkey
	output=[]
	#c="".to_i()+(k)% 26
	i=0
	while i<word.length
		output[i]=(check(word[i])+k)%26
		word[i]=check(output[i],true)
		i+=1
	end
	return word
end
def KD eword,shiftkey=3
	k=shiftkey
	output=[]
	#c="".to_i()-(k)% 26
	i=0
	while i<eword.length
		output[i]=(check(eword[i])-k)%26
		eword[i]=check(output[i],true)
		i+=1
	end
	return eword
end
def Cesser word,key=3
		str=word.downcase
		print "K-chiperE:\t",KE(str,key),"\n"
		print "K-chiperD:\t",KD(str,key),"\n"
end
######## Hill-Chiper
def HE word,key
	i=0
	while i<word.length
		j=0
		while j<word.length
			word[i][j]=word[i][j].downcase
			word[i][j]=check(word[i][j])
			j+=1
		end
		i+=1
	end	
	w=CM.new((word.length/2).floor)
	w::fill_matrix(word)
	r=w::build(word.length)
	w::fill_matrices(word,key);
	output=w::mul()
	str=""
	for i in (0...(output.length))
		for j in (0...(output[i].length))
			c=check(output[i][j]%26,true)
			r[i][j]=c
			str+=r[i][j]
		end
	end
	return str
end
def inverse(a,b)
	r=nil
	for i in (0...b)
		r=(a*i)%b
		if r==1
			return i
			break
		end
	end
end
def HD word,key
	i=0
	while i<word.length
		j=0
		while j<word[0].length
			word[i][j]=word[i][j].downcase
			word[i][j]=check(word[i][j])
			j+=1
		end
		i+=1
	end	
	w=CM.new()
	w::fill_matrix(word)
	r=w::build(word.length)
	d=w::getdet(key)
	if d<0
		d+=26
	end
	inv=inverse(d,26)
	key=w::adj(key)
	for i in (0...(key.length))
		for j in (0...(key[0].length))
			k=key[i][j]
			if k<0
				k+=26
			end
			k*=inv
			key[i][j]=k%=26
		end
	end
	w::fill_matrices(word,key)
	output=w::mul()
	r=w::build(word.length)
	str=""
	for i in (0...(output.length))
		for j in(0...(output[0].length))
			r[i][j]=check(output[i][j]%26,true)
			str+=r[i][j]
		end
	end
	return str
end
def Hill word,key,enc=true
	str=""
	len=(word.length/2).floor
	m=CM.new()
	word=m::AtoMatrix(word,len,len)
	#word=AtoCM(word,(word.length/2).floor,(word.length/2).floor)
	if enc==true
		enc=HE(word,key)
		print" Encrypted:\t" ,enc,"\n\n"
		return enc
	else
		dec=HD(word,key)
		print" Decrypted:\t",dec,"\n\n"
		return dec
	end
end
K=[[3,3],[2,5]]
M="HATS"
Hill(Hill(M,K),K,false)
###vigenere-Cipher
def Venc word,key
	word=word.downcase
	key=key.downcase
	c=[]
	i=0
	j=0
		for i in (0...(word.length))
			m=(check(word[i])+(check(key[i])))%26
			if m>check('z')
				m=m-26
			else
				m=m
			end
				c.push(m)
		end	
		me=check(c[0],true)
		for i in (1...(c.length))
			me+=check(c[i],true)
		end
	return me
end
def Vdec eword,key
	eword=eword.downcase
	key=key.downcase
	c=[]
	i=0
	j=0
		for i in (0...(eword.length))
			m=(check(eword[i])-(check(key[i])))%26
			if m<check('a')
				m=m+26
			else
				m=m
			end
				c.push(m)
		end
		me=check(c[0],true)
		for i in (1...(c.length))
			me+=check(c[i],true)
		end
	return me
end
def Vigenere
	word="hello"
	key="go"
	c=[]
	word="ATTACKATDAWN".downcase
	key="LEMONLEMONLE".downcase
	print"\n\t vigenere-Cipher\n\n"
	print"Encrypted:\t", Venc(word,key),"\n"
	print "Decrypted:\t",Vdec(Venc(word,key),key),"\n\n"
end
###VernamStream-Cipher
def VSenc(word,key)
	w=0
	k=0
	c=[]
	begin
		for i in (0...(word.length))
		if word[i]!=nil||key[i]!=nil
			w=check(word[i])
			k=check(key[i])
		end
		c.push w^k
	end
	s=("%s"%c[0]).to_i()
	if s>26
		s%=26
	else
	end
	mc=check(s,true)
	for i in (1...(c.length))
		s=("%s"%c[i]).to_i()
		if s>26
		 s%=26
		end
		 mc+=check(s,true)
	end
	return mc
	rescue Exception => e
		print e.message
	end
end
def VSdec(word,key)
	w=0
	k=0
	c=[]
	begin
		for i in (0...(word.length))
		if word[i]!=nil||key[i]!=nil
			w=check(word[i])
			k=check(key[i])
		end
		c.push w^k
	end
	s=("%s"%c[0]).to_i()
	if s>26
		s%=26
	end
	mc=check(s,true)
	for i in (1...(c.length))
		s=("%s"%c[i]).to_i()
		if s>26
		 s%=26
		end
		mc+=check(s,true)
	end
	return mc
	rescue Exception => e
		print e.message
	end
end
def VernamStream
	word = "abdo"
	key  = "road"
	print "\n\tVernamStream(XOR-Cipher)\n\n"
	print "Encrypted:\t",VSenc(word,key),"\n\n"
	print "Decrypted:\t",VSdec(VSenc(word,key),key),"\n\n"
end
##Affine
def Aenc word,key=[7,2]
	c=[]
	#W= a*m+b mod 26
	for i in (0...(word.length))
		c.push (check(word[i])*key[0]+key[1])%26
	end
	output=check(c[0],true)
	for i in (1...(c.length))
		output+=check(c[i],true)
	end
	return output
end
def Adec word,key=[7,2]
	#W= a inv * m-b mod 26
	c=[]
	for i in (0...(word.length))
		c.push (inverse(key[0],26)*(check(word[i])-key[1]))%26
	end
	output=check(c[0],true)
	for i in (1...(c.length))
		output+=check(c[i],true)
	end
	return output
end
def Affine word,enc=true,key=[]
	word=word.downcase
	encword=Aenc(word)
	decword=Adec(word)
	if enc == true
		print" Encrypted:\t",encword,"\n\n"
		return encword
	else
		print" Decrypted:\t",decword,"\n\n"
		return decword
	end
end
def ORenc word
	odd=[]
	even=[]
	if word.length==4
		w=check(word[0])
		if w!=nil
			if w%2==1
				odd[0]=check(w,true)
			else
				even[0]=check(w,true)
			end
		end
		for i in (1...(word.length))
			w=check(word[i])
			if w!=nil
				if w%2==1
					odd.push check(w,true)
				else
					even.push check(w,true)
				end
			end
		end
	end
	return odd,even
end
def ORdec word
	if word.length==2
		odd=word[0]
		even=word[1]
		output=[]
		for i in (0...(odd.length))
			w=odd[i]+even[i]
			if (odd[i+1]!=nil) && (even[i+1]!=nil)
				w+=ascisrt(odd[i+1]+even[i+1])
				output.push w
			end 
		end
		outputs=output[0]
		for i in (1...(output.length))
			outputs+=output[i]
		end
	end
	return outputs
end
def ERenc word
	odd=[]
	even=[]
	if word.length==4
		w=check(word[0])
		if w!=nil
			if w%2==1
				odd[0]=check(w,true)
			else
				even[0]=check(w,true)
			end
		end
		for i in (1...(word.length))
			w=check(word[i])
			if w!=nil
				if w%2==1
					odd.push check(w,true)
				else
					even.push check(w,true)
				end
			end
		end
	end
	return even,odd
end
def ERdec word
	if word.length==2
		odd=word[1]
		even=word[0]
		output=[]
		for i in (0...(odd.length))
			w=even[i]+odd[i]
			if (odd[i+1]!=nil) && (even[i+1]!=nil)
				w+=ascisrt(even[i+1]+odd[i+1])
				output.push w
			end 
		end
		outputs=output[0]
		for i in (1...(output.length))
			outputs+=output[i]
		end
	end
	return outputs
end
#print"\n\tAffine-Cipher\t\n\n"
#Affine(Affine('abdo'),false)
###Row-transition##########
def Row word,key=[4,3,1,2,5,6,7]
	length=key.length
	w=[]
	w.push Substr(word,0,length)
	n=word.length/key.length
	n=n.floor
	i=n-n+1
	while i<n
		s=Substr(word,length*i,length*(i+1))
		if (s!="")||(s!=nil)
			w.push s
		end 
		i+=1
	end
	s=Substr(word,length*i,word.length)
	if (s!="")||(s!=nil)
		w.push s
	end  
	return w
end
def Rowenc word,key=[4,3,1,2,5,6,7]
	w=Row(word,key)
	r={}
	for i in (0...(key.length))
		r[key[i]]=subchrs(w,i,key.length)
	end
	print r
	output={}
	str=""
	for i in(1..(r.length))
		output[i]=r[i]
		for j in(0...(output[i].length))
			str+=output[i][j]
		end
	end
	return str
end
def Col word,key
	length=word.length/key.length
	length=length.floor
	w=[]
	w.push Substr(word,0,length)
	n=word.length/length
	n=n.floor
	i=n-n+1
	while i<n
		s=Substr(word,length*i,length*(i+1))
		if (s!="")||(s!=nil)
			w.push s
		end 
		i+=1
	end
	s=Substr(word,length*i,word.length)
	if (s!="")||(s!=nil)
		w.push s
	end  
	return w
end
def Rowdec word,key=[4,3,1,2,5,6,7]
	w=Col(word,key)
	length=w[0].length
	r={}
	for i in (0...(key.length))
		r[i+1]=subchrs(w[i],0,length)
	end
	_r=[]
	n=(word.length/key.length).floor
	for i in (0...(n))
		s=hsubchrs(r,i,key)
		if s!=nil
			_r.push(s)
		end
	end
	str=""
	for i in (0...(_r.length))
		for j in(0...(_r[i].length))
			c=_r[i][j]
			if c=='x'
				c=""
			end
			str+=c
		end
	end
	return str
end
#####################
def Row_transition(word,enc=true)
	if enc==true
		print " Encrypted:\t",Rowenc(word),"\n\n"
		return Rowenc(word)
	else
		print " Dncrypted:\t",Rowdec(word),"\n\n"
		return Rowdec(word)
	end
end
w="attackpostponeduntilltwoam"
#print "\n\tRow-transition\n\n"
#Row_transition(Row_transition(w),false)
I=[[7,0],[19,18]]
#p InverseCM(adj(cofactor([[1,2,3],[4,5,6],[7,8,9]])),det([[1,2,3],[4,5,6],[7,8,9]]))
#print"\n\tHill-Chiper\n\n"
#Hill(Hill(M,K),K,false)
key=0x13345799bbcdff1
s="%b"%key
_key={}
for i in (0...(s.length))
_key[i+1]=s[i].to_i()
end
m=[[57,49,41,33,25,17,9],[1,58,50,42,34,26,18],[10,2,59,51,43,35,27],[19,11,3,60,52,44,36],[63,55,47,39,31,23,15],[7,62,54,46,38,30,22],[14,6,61,53,45,37,29],[21,13,5,28,20,12,4]]
P=[]
for i in (0...(m.length))
	for j in (0...(m[i].length))
		p=""
		k=m[i][j]
			if _key.has_key?(k)==true
				if _key[k]==1
					p+='1'#1
				end
				if _key[k]==0
					p+='0'#0	
				end	
			else
				#p+=' '	
			end
			P.push p
	end
end
str=P.join
l=Substr(str,0,str.length/2).to_i()
_r=Substr(str,str.length/2,str.length).to_i()
o=[]
for i in(1...16)
	if (i==1)||(i==16)
		l<<=1
		_r<<=1
		o.push "%b"%(l||_r)
	end
	if i%2!=0
		if (i==3)||(i==5)||(i==7)||(i==11)||(i==13)||(i==15)
			l<<=2
			_r<<=2
		end
		if i==9
			l<<=1
			_r<<=1
		end
		o.push "%b"%(l||_r)
	else
		if i==2
			l<<=1
			_r<<=1
		else
			l<<=2
			_r<<=2
		end
		o.push "%b"%(l||_r)
	end
end
def chash(n,size=48)
	o={}
	for i in(0...size)
		o[i+1]=n[i].to_i()
	end
	return o
end
m2=[[14,17,11,24,1,5,3,28],[15,6,21,10,23,19,12,4],[26,8,16,7,27,20,13,2],[41,52,31,37,47,55,30,40],[51,45,33,48,44,49,39,56],[34,53,46,42,50,36,29,32]]
_P=[]
for l in o
	_key=chash(l)
	for i in (0...(m2.length))
		for j in (0...(m2[i].length))
			p=""
			k=m2[i][j]
			if _key.has_key?(k)==true
				if _key[k]==1
					p+='1'#1
				end
				if _key[k]==0
					p+='0'#0	
				end	
			else
				#p+=' '	
			end
			_P.push(p.to_i())
		end			
	end
end
#p=AtoCM(_P,16,16)
#__P=[]
'''for i in (0...(p.length))
		__P[i]=p[i].join().to_i
end'''
#p __P
'''
def PF key,word
	w=[]
	length=(word.length/2).floor
	i=0
	while i<length
		s=Substr(word,i*2,(i+1)*2)
		if (s!=nil) || (s!='')
			w.push s.chars
		end
		i+=1
	end
	s=Substr(word,i*2,word.length)
	if (s!=nil) || (s!='')
			w.push s.chars
	end
	def gen _key,length=5
	key=bCM(length,length)
	key[0]=Substr(_key,0,key.length).chars.uniq
	key[1]=Substr(_key,key.length,_key.length).chars.uniq
	key[1]+=generate_str("",(key.length-key[1].length)).chars
	for i in(2...key.length)
		if key[i]!=key[i-1]
			g=generate_str("",key.length).chars.uniq
			if g.length<key.length
				g+=generate_str("",key.length-g.length).chars.uniq
			end
			r=g&g
			key[i]=r
		end
	end
	return key
	end
	return gen(key),w
end
pf=PF("playfaire","hidethegoldinthetreestump")
''''''for i in (0...(pf[0].length))
	for j in(0...(pf[0][0].length))
		inp=intersection(pf[0],false,i,j)
		w=pf[1]
		p=dim(w,w[j])
		p p
	end
end''''''
w=pf[1]
p =dim(w,'"e"')
p pintersec(pf[0],p[3],p[2])
s="%s"%(s.to_i(2))
_p=[]
length=(s.length/2).floor
i=0
while i<length
	_p.push Substr(s,i*2,(i+1)*2).to_i
	i+=1
end
_p.push Substr(s,i*2,s.length).to_i
#p s
for i in _p
	i%=26
#p check(i%26,true)
end
#p _p
#print _genNum(0,26,(26/4).floor)'''
'''def S_Des word,key
	p10=_genNum(0,10)
end'''
def S_DES
	def subKeys _key
		_k=_key
		_k=_k.bytes[0]
		_k=("%b"%_k)
		p_={}
		_p=[]
		p10=[]
		for i in (1..10)
			p10[i-1]=rand(10)
		end
		for i in (1.._k.length)
		p_[i]=_k[i-1].to_i()
		end
		for i in (0...p10.length)
			if p_.has_key?(p10[i])==true
				if p_[p10[i]]==1
					p_[p10[i]]=1
				elsif p_[p10[i]]==0
						p_[p10[i]]=0
				end
				if i<_k.length
					_k[i]="%s"%p_[p10[i]]
				end
			end
		end
		s1=(_k.to_i(2)<<1).to_s(2)
		s2=(_k.to_i(2)<<2).to_s(2)
		p_={}
		for i in (1..(s1.length))
			p_[i]=s1[i-1].to_i
		end 
		p8=[]
		for i in (1..8)
			p8[i-1]=rand(8)
		end
		for i in (0...(p8.length))
			if p_.has_key?(p8[i])==true
				if p_[p8[i]]==1
					p_[p8[i]]=1
				elsif p_[p8[i]]==0
						p_[p8[i]]=0
				end
				if i<s1.length
					s1[i]="%s"%p_[p8[i]]
				end
			end
		end
		p_2={}
		for i in (1..(s2.length))
			p_2[i]=s2[i-1].to_i
		end 
		for i in (0...(p8.length))
			if p_2.has_key?(p8[i])==true
				if p_2[p8[i]]==1
					p_2[p8[i]]=1
				elsif p_2[p8[i]]==0
						p_2[p8[i]]=0
				end
				if i<s1.length
					s2[i]="%s"%p_[p8[i]]
				end
			end
		end
		k1=s1.to_i(2)
		k2=s2.to_i(2)
		return k1,k2
	end
	def S_BOXes k=[]
		s_boxes=bCM(k.length,k.length)
		for i in (0...(s_boxes.length))
			s_boxes[i]=bCM((s_boxes.length*2),(s_boxes.length*2))
			for j in (0...(s_boxes[i].length))
				s=s_boxes[i][j]=_genNum(0,(s_boxes[i].length),s_boxes[i].length)
				if s.length<s_boxes[i].length
					for k in (0...(s_boxes[i].length-s.length))
						s.push generate_num(0,s_boxes[i].length)
					end
				end
			end
		end
		s_bes={}
		for i in (0...s_boxes.length)
			s_bes[i]=s_boxes[i]
		end
		return s_bes
	end
	def intersec matrix,i,row,col
		return intersection(matrix[i],row,col)	
	end
	def enc word,key
		subkeys=subKeys(key)
		s_boxes=S_BOXes(subkeys)
		rigths=[]
		lefts=[]
		ip=[]
		for i in (1..word.length)
			ip[i-1]=rand(word.length)
		end
		pw={}
		for i in (1..(ip.length))
			pw[i]=word[i-1].to_i
		end
		for i in (0...(ip.length))
			if pw.has_key?(ip[i])==true
				if pw[ip[i]]==1
					pw[ip[i]]=1
				elsif pw[ip[i]]==0
					pw[ip[i]]=0
				end
			end
			word[i]="%s"%pw[ip[i]]
		end
		
		s=word
		lefts.push Substr(s,0,s.length/2)
		rigths.push Substr(s,s.length/2,s.length)
		encw=""
		lefts[1]=rigths[0]
			if rigths[0].length<subkeys[0].to_s(2).length
			expr=exp(rigths[0])
				if expr.length>lefts[0].length
					s=s_box(expr,s_boxes)
					rigths[1]=((lefts[0].to_i(2)^s)^rigths[0].to_i(2)).to_s(2)
					encw+=rigths[1]+lefts[0]
				end
			end
		if (encw!="")&&(encw!=nil)
			return encw
		end
	end 
	def s_box rls,s_boxes
		r=[]
		r.push Substr(rls,0,rls.length/2),Substr(rls,rls.length/2,rls.length)
		rows=[]
		cols=[]
		rls=r
		for i in (0...(rls.length))
			for j in(0...(rls[i].length))
				if j%rls[i].length==0
					rows.push rls[i][j].to_i() 
				elsif j%rls[i].length==1
					cols.push rls[i][j].to_i() 
				end
			end
		end
		points=[]
		for i in (0...rows.length)
			points.push intersec(s_boxes,i,rows[i],cols[i]).to_s(2)
		end
		return points.join.to_i(2)
	end
	def exp rls
		expA=[]
		for i in (1..8)
			expA[i-1]=rand(8)
		end
		p_={}
		for i in (1..(expA.length))
			p_[i]=rls[0][i-1].to_i
		end 
			for i in (0...(expA.length))
				if p_.has_key?(expA[i])==true
					if p_[expA[i]]==1
							p_[expA[i]]=1
					elsif p_[expA[i]]==0
								p_[expA[i]]=0
					end
				end
			end
			r=[]
			for i in (1..p_.length)
				r[i-1]=p_[i]
			end
			r=r.join
			if r!=0
				return r 
			end
	end
	encw=enc("100010110101",'z')
	if (encw!="")&&(encw!=nil)
		p encw
	end
end
#S_DES()