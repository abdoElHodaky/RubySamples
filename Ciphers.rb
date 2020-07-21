load"CM.rb"
class Ciphers
	@@word
	@@cipherText
	@@i=false
	@@matrix=nil
	@@CM=nil
	def initialize
		@@matrix=CM::new
		@@CM=CM
	end
	def self.inv a,b,c=b
		r=0
	    r=(a*b)%c
	    if r==1
	      return b
	    else
	      inv(a,b-1,c)
	    end
	end
	def self.gcd a,b
		if b!=0
			return gcd(b,a%b)		
		else
			return a
		end
	end	
	def self.ICheck mode,n=nil
			inv={}
			for i in (0...mode)
				_i=self.inv(i,mode)
				inv[i]=_i
			end
			if n!=nil && @@i==true
				return inv[n]
			else
				return inv
			end
	end	
	def self.Substr str,offset,endset
		_str=""
		for i in (offset...endset)
			_str+=str[i]
		end
		return _str
	end
	def self.SubArray array,offset,endset
		_arr=[]
		for i in (offset...endset)
			_arr.push array[i]
		end
		return _arr
	end
	def self.subchrs array,index,length
	chrs=[]
		for i in (0...(array.length))
			if index<length
				c=array[i][index]
				if c==nil
					c='x'
				end
				chrs.push c
			end
		end
	return  chrs
	end
	def self.hsubchrs hash,index,key,length=key.length
	chrs=[]
		for i in(0...(key.length))
			k=hash[key[i]]
			if k!=nil
				if index<length
					c=k[index]
				end
				chrs.push c
			end
		end
		return chrs
	end
	def self.atoW arr
			word=arr
			str=""
			word.each do |i|
				str+=i.chr
			end
			return str
	end
	def self.wtoA arr
			word=arr
			str=[]
			word.each_byte do |i|
				str.push i
			end
			return str
	end
	def self.Check letter,reverse=false,letters=false
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
		def self.initW(word)
			@@word=word.downcase
		end
		def self.initC(cword)
			@@cipherText=cword.downcase
		end
		def self.mode arr,mod=26
			for i in (0...(arr.length))
				for j in (0...arr[i].length)
				if arr[i][j]<0
					arr[i][j]+=mod			 	
				 end 
					arr[i][j]%=mod
				end
			end
			return arr
		end
		def self.intersec matrix,r=0,c=0
			self.new
			rows=CM::getrows(matrix,r)
			cols=CM::getcols(matrix,c)
			for i in (0...rows.length)
				for j in (0...cols.length)
					if rows[i]==cols[j]
						_ins=rows[i]||cols[j]
						return _ins
					end
				end
			end
		end
		def self.ECheck word
			equal=false
			for i in (1...word.length)
				#for j in (0...word.length)
					if word[i-1]==word[i]
					equal=true	
					end
				#end
			end
			if equal==true
				return equal
			else
				return false
			end
		end
		def self.generate_str (word,length,sub=false,rand=false,all=false)
		str=self::Check('',false,true)
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
end
class Cessear<Ciphers
	@@cipher=nil
	@@key=nil
	def self.enc(key=nil)
		self::genKey
		if key==nil
			key=@@key
		end
		word=@@word
		w=''
		for i in (0...(word.length))
			w+=self::Check((self::Check(word[i])+key)%26,true)
		end
		@@cipher=w
		return w
	end
	def self.dec(key=nil)
		word=@@cipher
		w=''
		if key!=nil
			for i in (0...word.length)
				c=self::Check(word[i])-key
				if c<0
					c+=26
				else
					c%=26
				end
				w+=self::Check(c,true)
			end
			return w
		end
		if key==nil
			print "\e[9;101;31m#{"\t--------Expections--------\t"}\e[0m\n\n"
			print "\e[6;105;30m#{"\tKey\t\e[4;0;32mword\e[0m"}\e[0m\n\n"
			for i in(0...26)
				t=Time.now
				sleep((t+1-Time.now)*0.26)
				word=self::dec(i)
				if self::ECheck(word)!=true
					if word==@@word
						puts "\t\e[8;33;102m#{i}\e[0m \e[4;0;36m#{"\t"+word}\e[0m"
						break
					else
						puts "\t\e[8;30;102m#{i}\e[0m \e[4;0;32m#{"\t"+word}\e[0m"
					end
				end
			end
			print "\n\e[9;101;31m#{"\t--------EndExpections--------\t"}\e[0m\n"
		end
		#self::initW(w)
	end
	def self.getKey
		cipher=@@cipherText
		plainText=@@word
		k=0
		for i in (0...(cipher.length))
			k=self::Check(cipher[i])-self::Check(plainText[i])
		end
		if k<0
			k+=26
			elsif k>26
				k%=26
		end
		key=k
		return key
	end
	def self.genKey
		@@key=rand(26)
	end
end
class Affine<Ciphers
	@@key=[]
	def self.enc(key1=nil,key2=nil)
		self::genKey
		if key1==nil && key2==nil
			key1=@@key[0]
			key2=@@key[1]
		end
		word=@@word
		w=''
		for i in ((0...word.length))
			if key1%2==1
				c=key1*(self::Check(word[i])+key2)
				if c<0
					c+=26
				else
					c%=26
				end
				w+=self::Check(c%26,true)
			end
		end
		return w
	end
	def self.dec(key1=nil,key2=nil)
		w=''
		word=@@word
		if (key1!=nil)&&(key2!=nil)
			for i in ((0...word.length))
				if key1%2==1
					inv=self::ICheck(26,key1)
					if inv!=0 && inv!=nil
						c=inv*self::Check(word[i])-key2
							if c>26
								c%=26
							elsif c<0
								c+=26
							end
						w+=self::Check(c%26,true)
					end
				end
			end
			return w
			
		else
			
			print "\e[9;101;31m#{"\t--------Expections--------\t"}\e[0m\n\n"
			print "\e[6;105;30m#{"\tKey\t\e[4;0;32mword\e[0m"}\e[0m\n\n"
			for i in(1...26)
				if i%2==1
					for j in (0...26)
						t=Time.now
						sleep((t+1-Time.now)*0.26)
						word=self::dec(i,j)
							if self::ECheck(word)!=true
								if word==@@word
									puts "\t\e[8;33;102m#{i},#{j}\e[0m \e[4;0;36m#{"\t"+word}\e[0m"
									break
								else
									puts "\t\e[8;30;102m#{i},#{j}\e[0m \e[4;0;32m#{"\t"+word}\e[0m"
								end
							end
						break
					end	
				end
			end
			print "\n\e[9;101;31m#{"\t--------EndExpections--------\t"}\e[0m\n"
		
		end
	end
	def self.getKey
		cipher=@@cipherText
		plainText=@@word
		a=nil
		b=nil
		for i in(1...26)
			for j in (0...26)
				if i%2==1
					word=self::enc(i,j)
					if word==cipher
						return i,j
						break
					end
				end
			end
		end
	end
	def self.genKey
		k1=rand(26)
		k2=rand(26)
		loop{
			k1=rand(26)
			if k1%2==1
				break
			end
		}
		@@key=[k1,k2]
	end
end

class Hill < Ciphers
	@@key=nil
	@@c=Ciphers.new
	@@cipher=nil
	def initialize len
		Hill::initK
	end
	def self.genKey len
		key=@@matrix::build(len)
		for i in (0...len)
			for j in (0...len)
				key[i][j]=rand(26)
			end
		end
		@@key=key
		return key
	end
	def self.enc k=nil
		if k.instance_of?Array 
			k=@@matrix::AtoMatrix(k,Math.sqrt(k.length),Math.sqrt(k.length))
		else
			if k==nil
				k=@@key
			end
		end
		
		word=[]
		for i in (0...@@word.length)
			word.push self::Check(@@word[i])
		end
		w=@@matrix::AtoMatrix(word,Math.sqrt(word.length),Math.sqrt(word.length))
		#@@matrix::fill_matrices(k,w)
		keyMatrixObj,wMatrixObj=@CM::create(k),@CM::create(w)
		c=self::mode((keyMatrixObj*wMatrixObj)::resMatrix,26)
		enc=""
		for i in c
			for j in i
				enc+=self::Check(j%26,true)
			end
		end
		@@cipher=enc
		return enc
	end
	def self.dec k=nil
		if k.instance_of?Array 
			k=@@matrix::AtoMatrix(k,Math.sqrt(k.length),Math.sqrt(k.length))
		else
			if k==nil
				k=@@key
			end
		end
		word=[]
		for i in (0...@@word.length)
			word.push self::Check(@@cipher[i])
		end
		w=@@matrix::AtoMatrix(word,Math.sqrt(word.length),Math.sqrt(word.length))
		inv=self::inv(@@matrix::getdet(k),26)
		k=self::mode(@@CM::mulS(@@matrix::adj(k),inv))
		keyMatrixObj,wMatrixObj=@CM::create(k),@CM::create(w)
		#@@matrix::fill_matrices(k,w)
		d=self::mode((keyMatrixObj*wMatrixObj)::resMatrix)
		dec=""
		for i in d
			for j in i
				dec+=self::Check(j%26,true)
			end
		end
		return dec
	end
	def self.initK
		len=Math::sqrt(@@word.length).to_i
		loop{
			arr=[]
			ke=self::genKey(len)
			for i in (0...ke.length)
 				for j in (0...ke[i].length)
 					arr.push ke[i][j]
 				end
			end
			self::enc 
 			if @@word==self::dec
 				return arr
 				break
 			end
		}	

	end
end
class Column__transposition<Ciphers
	def self.Kinit keyword
		for i in (0...keyword.length)
			for j in (1...keyword.length)
				if keyword[j]<keyword[i]
					tmp=keyword[j]
					keyword[j]=keyword[i]
					keyword[i]=tmp
				end
			end
		end
		w=[]
		for i in (0...keyword.length)
			w[i]=i+1
		end
		return w
	end
	def self.Row key
		word=@@word
		num=(word.length/key.length).floor
		length=key.length
		i=0
		arr=[]
		while i<num
			s=self::Substr(word,i*length,(i+1)*length)
			if s!=nil
				arr.push s	
			end
			i+=1
		end
		s=self::Substr(word,i*length,word.length)
			if s!=nil
				arr.push s	
			end
		return arr
	end
	def self.Col key
		word=@@word
		num=(word.length/key.length).floor
		length=num
		num=(word.length/num).floor
		i=0
		arr=[]
		while i<num
			s=self::Substr(word,i*length,(i+1)*length)
			if s!=nil
				arr.push s	
			end
			i+=1
		end
		s=self::Substr(word,i*length,word.length)
			if s!=nil
				arr.push s	
			end
		return arr
	end
	def self.enc key
		if key.instance_of?(String)==true
			key=self::Kinit(key)
		end
		w=self::Row(key)
		r={}
		for i in (0...(key.length))
			r[key[i]]=self::subchrs(w,i,key.length)
		end
		_r={}
		for i in (1..(key.length))
			_r[i]=r[i]
		end
		word=""
		for i in (1..(_r.length))
			for j in (0...(_r[i].length))
				word+=_r[i][j]
			end
		end
		self::initW(word)
		return word
	end
	def self.dec key
		if key.instance_of?(String)==true
			key=self::Kinit(key)
		end
		w=self::Col(key)
		r={}
		for i in (1...(key.length))
			r[i]=self::subchrs(w[i-1],0,key.length)#prevent empty chars(x)
		end
		_r=[]
		for i in (0...(w[0].length))#prevent empty chars and take len(word) after not take empties(x)
			s=self::hsubchrs(r,i,key)
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
end
class Vignere <Ciphers
	@@cipher=nil
	def self.enc(key)
		key=key.downcase
		word=@@word
		w=''
		for i in (0...(word.length))
			c=self::Check(word[i])+self::Check(key[i])
			if c<0
				c+=26
			else
				c%=26
			end
				w+=self::Check(c,true)
		end
		@@cipher=w
		return w
	end
	def self.dec(key=nil)
		word=@@cipher
		w=''
		if key!=nil
			key=key.downcase
			for i in (0...word.length)
				c=self::Check(word[i])-self::Check(key[i])
				if c>26
					c-=26
				elsif c<0
					c+=26
				else
					c%=26
				end
				w+=self::Check(c,true)
			end
			return w
		else
			print "\e[9;101;31m#{"\t--------Expections--------\t"}\e[0m\n\n"
			print "\e[6;105;30m#{"\t\tKey\t\t\e[4;0;32mword\e[0m"}\e[0m\n\n"
			for i in (0...26)
				for j in (0...word.length)
					key=self::generate_str(word,word.length,false,true,false)
					word=self::dec(key)
					t=Time.now
					sleep((t+1)-Time.now)
					#if self::ECheck(word)!=true
					puts "\t\e[5;100;30m#{key}\e[0m\t\e[3;91;33m#{word}\e[0m"	
					#end
				end
			end
			print "\e[9;101;31m#{"\t--------EndExpections--------\t"}\e[0m\n\n"
		end
	end
	def self.getKey
		cipher=@@cipherText
		plainText=@@word
		k=[]
		for i in (0...cipher.length)
			c=self::Check(cipher[i])-self::Check(plainText[i])
			if c<0
				c+=26
			elsif c>26
				c%=26
			end
		k.push self::Check(c,true)
		end
		return k.join
	end
end
class S_DES<Ciphers
	@@p10=[3,5,2,7,4,1,0,1,9,8,6]
	@@p8=[6,3,7,4,8,5,10,9]
	@@Ep=[4,1,2,3,2,3,4,1]
	@@S_boxes=[[[1,0,3,2],[3,2,1,0],[0,2,1,3],[3,1,0,3]],[[0,1,2,3],[2,0,1,3],[3,0,1,0],[2,1,0,3]]]
	@@p4=[2,4,3,1]
	@@Ip=[2,6,3,1,4,8,5,7]
	@@IIP=[4,1,3,5,7,2,8,6]	
	@@keys
	def self.subKeys key
		p10=@@p10	#[3,5,2,7,4,1,0,1,9,8,6]
		p8=@@p8		#[6,3,7,4,8,5,10,9]
		k={}
		for i in (0...p10.length)
			k[i+1]=key[i]
		end
		pk=[]
		for i in (0...p10.length)
			if k.has_key?p10[i]
				if k[p10[i]]=='1'
					pk.push'1'
				elsif k[p10[i]]=='0'
					pk.push'0'	
				end
			end
		end
		pk=pk.join.to_i(2)
		pk>>=1
		k1=pk.to_s(2)
		_k=k1.to_i(2)
		for i in (0...k1.length)
			k[i+1]=k1[i]
		end
		pk=[]
		for i in (0...p8.length)
			if k.has_key?p8[i]
				if k[p8[i]]=='1'
					pk.push'1'
				elsif k[p8[i]]=='0'
					pk.push'0'	
				end
			end
		end
		k1=pk.join.to_i(2)
		_k>>=1
		_k=_k.to_s(2)
		for i in (0..._k.length)
			k[i+1]=_k[i]
		end
		pk=[]
		for i in (0...p8.length)
			if k.has_key?p8[i]
				if k[p8[i]]=='1'
					pk.push'1'
				elsif k[p8[i]]=='0'
					pk.push'0'	
				end
			end
		end
		k2=pk.join.to_i(2)
		@@keys=[k1,k2]
		return[k1,k2]
	end
	def self.S_box rows,cols
		s0=@@S_boxes[0]
		s1=@@S_boxes[1]
		for i in (0...s0.length)
			for j in (0...s0[i].length)
				s0[i][j]="%b"%s0[i][j]
				s1[i][j]="%b"%s1[i][j]
			end
		end
		i=rows[0].to_i()
		_i=rows[1].to_i()
		j=cols[0].to_i()
		_j=cols[1].to_i()
		return[self::intersec(s0,i,j),self::intersec(s1,_i,_j)]
	end
	def self.enc
		word=@@word
		keys=@@keys
		ip=@@Ip
		k={}
		for i in (0...ip.length)
			k[i+1]=word[i]
		end
		pk=[]
		for i in (0...ip.length)
			if k.has_key?ip[i]
				if k[ip[i]]=='1'
					pk.push'1'
				elsif k[ip[i]]=='0'
					pk.push'0'	
				end
			end
		end
		word=pk.join
		left=self::Substr(word,0,(word.length/2).floor)
		right=self::Substr(word,(word.length/2).floor,word.length)
		right1=self::roundF(self::expand(right),keys[0])^ right.to_i(2)
		#right2=self::roundF(self::expand(right1),keys[1])^right1
		msg=[right1.to_s(2),right].join
		
		ip=@@IIP
		for i in (0...ip.length)
			k[i+1]=msg[i]
		end
		pk=[]
		for i in (0...ip.length)
			if k.has_key?ip[i]
				if k[ip[i]]=='1'
					pk.push'1'
				elsif k[ip[i]]=='0'
					pk.push'0'	
				end
			end
		end
		msg1=pk.join
		return msg1	

	end
	def self.roundF right,key
		p4=@@p4
		tmp=(right^key).to_s(2)
		l=self::Substr(tmp,0,(tmp.length/2).floor)
		r=self::Substr(tmp,(tmp.length/2).floor,tmp.length)
		l=self::S_box([l[0],l[3]],[l[1],l[2]])
		l=l.join
		r=self::S_box([r[0],r[3]],[r[1],r[2]])
		r=r.join
		tmp=[l,r].join
		k={}
		for i in (0...tmp.length)
			k[i+1]=tmp[i]
		end
		pk=[]
		for i in (0...p4.length)
			if k.has_key?p4[i]
				if k[p4[i]]=='1'
					pk.push'1'
				elsif k[p4[i]]=='0'
					pk.push'0'	
				end
			end
		end
		tmp=pk.join.to_i(2)
		return tmp
	end
	def self.expand right
		k={}
		for i in (0...@@Ep.length)
			k[i+1]=right[i]
		end
		pk=[]
		for i in (0...@@Ep.length)
			if k.has_key?@@Ep[i]
				if k[@@Ep[i]]=='1'
					pk.push'1'
				elsif k[@@Ep[i]]=='0'
					pk.push'0'	
				end
			end
		end
		right=pk.join
		return right.to_i(2)
	end
end
class RSA < Ciphers
	@@key=nil
	@@lChunk=3
	@@cipher=nil
	def initialize k
		RSA::initK k
		$l=@@lChunk
	end
	def self.initK k
		@@key=self::genKey k
		return @@key
	end
	def self.Nprime(n)
		pr=[]
		for i in (2...(Math::sqrt(n).floor))
		    if i%2==1
		        pr.push i
		    end
		end
		return pr
		end
		def self.pqgen k=8
			pq=[]
			#pr=Nprime(k**2)
			 '''for i in (0...2)
			 	pq[i]=pr[rand()*pr.length]
			 end'''
			 '''pq[0]=self::LPrime(k)
			 pq[1]=self::LPrime((k/2).floor)'''
			 p=self::GenPrime(k)
			 q=self::GenPrime(k)
			 if p!=q
			 	pq.push p,q
			 	return pq
			 else
			 	return self::pqgen k
			 end
			 
		end
		def self.gene n=nil
			e=(3...65537).to_a
			b=[]
			for i in (0...e.length)
			    if e[i]%2==1
			        b.push e[i]        
			    end
			end
			if n!=nil
				loop{
			    r=b[rand()*b.length]
			    if r<n
			        return r
			         break
			    end
				}	
			else
			r=b[rand()*b.length]
			return r
			end
			
		end
		def self.gend e,_p,_q,k=8
			t=((_p-1)*(_q-1))
			#loop { 
				d=self::inv(e,t)
				#if d<2**k
					return d
					#break
				#end
			#}
		end
		def self.genKey k
			pq=pqgen k
			e=gene 2**k
			d=gend(e,pq[0],pq[1],k)
			n=pq[0]*pq[1]
			t=((pq[0]-1)*(pq[1]-1))
			if ((self::gcd(e,pq[0]-1)==1 )&& (self::gcd(e,pq[1]-1)==1))||(self::gcd(e,t)==1)
				@@key=[n,e,d,t]
				return @@key
			else
				return self::genKey	k
			end
			
		end
		def self.ascii
			word=@@word	
			arr=[]
			word.each_byte	do |i|
				arr.push i
			end
			return arr
		end
		def self.enc key=nil
			chunks=self::ascii
			if chunks!=nil
				arr=[]
				if key!=nil
					for i in (0...(chunks.length))
						arr.push ((chunks[i]**key[1])% key[0])
					end
					@@cipher=arr
					return  arr
				else
					key=@@key
					return self::enc key
				end
			end
		end
		def self.dec key=nil
			chunks=@@cipher
			if chunks!=nil
				arr=[]
				if key!=nil
					for i in (0...(chunks.length))
						arr.push ((chunks[i]**key[2])% key[0])
					end
					word=""
					arr.each do |i|
						word+=(i%256).chr
					end
					return  word
				else
					key=@@key
					return self::dec key
				end
			end
		end
		def self.verifyK k=8,cipher
			loop{
			RSA::new(k)
			@@cipher=cipher
			word=self::dec 
			if word==@@word
				k=@@key
				return k
				break
			end
			}
		end
		def self.initKey k=8
			RSA::new(k)
			c=RSA::enc
			key=RSA::verifyK(k,c)
			return key
		end
		def self.word arr,k=8
			word=arr
			str=""
			word.each do |i|
				if i<49
					i+=49
				end
				str+=((i%2**k)).chr
			end
			return str
		end
		def self.initC arr
			_E=false
			arr.each do |i|
				if i.instance_of?Fixnum
					_E=true
				end
			end
			if _E==true
				@@cipher=arr
				return @@cipher
			end
		end
		def self.GenPrime k=8
			r=rand(2...(2**k))
			if r%2==1
				return r
			else
				return self.GenPrime k
			end
		end
end