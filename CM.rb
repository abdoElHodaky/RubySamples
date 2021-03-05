class CM
	@@matrix=[]
	@@rMul=0
  	@@resMul=false
	@resMatrix=[]
	def self.rMul v=nil
        @@rMul=v unless v==nil
        @@rMul
	end
  def self.resMul v=nil
        @@resMul=v unless v==nil
        @@resMul
	end
	def initialize(r=0)
	end
	def fill_matrix matrix
		if matrix[0].instance_of?(Array)==true
			for i in (0...(matrix.length))
				@@matrix[i]=matrix[i]
			end
			else
				@@matrix::pop() if @@matrix.length!=@@matrix[0].lenght
			@@matrix=self::AtoMatrix(matrix,Math.sqrt(matrix.length).ceil,Math.sqrt(matrix.length).ceil)
		end
		@resMatrix=@@matrix
		return @@matrix
	end
	def build(rows)
		matrix=[]
		for i in (0...(rows))
			matrix.push []
		end
		return matrix
	end
	def AtoMatrix array,rows,cols
		for i in (0...array.length)
			if array[i].instance_of?Array
				print"\e[5;90;31mIsMatrix\e[0m\n"
				return nil
				break
			end
		end
		matrix=build(rows)
		for i in (0...(array.length))
	    	matrix[i / rows][i % cols] = array[i];
	  	end
	  	if matrix[matrix.length-1].length==0
			matrix.pop
		end
	  	return matrix
	end
	def self.MtoArray matrix
    	return matrix.flatten
	end
	def self.getrows(matrix,r,c=nil)
		arr=[]
		for i in (0...matrix[r].length)
			arr.push matrix[r][i]
		end
	 if c!=nil
	 	return arr[c]
	 else
	 	return arr
	 end
	end
	def self.getcols(matrix,c,r=nil)
		arr=[]
		for i in (0...matrix.length)
			#arr.push matrix[i][c]
			arr.push self::getrows(matrix,i,c)
		end
	 if r!=nil
	 	return arr[r]
	 else
	 	return arr
	 end
	end
	def self.getSize matrix
		size=[]
		size[0]=matrix.length
		size[1]=matrix[0].length
		return size
	end
	def self.isSquare matrix 
		return CM::getSize(matrix)[0]==CM::getSize(matrix)[1]
	end
	def minor matrix,r=0,c=0
	        res=[]
            for i in (0...matrix.length)
                for j in (0...(matrix[i].length))
                    res.push (matrix[i][j]) if i!=r and c!=j
                end
            end
           return AtoMatrix(res,Math.sqrt(res.length).ceil,Math.sqrt(res.length).ceil)
	end
	def cofactors matrix
		if matrix==nil || matrix==[]
			matrix=@@matrix
		end
		if CM::isSquare(matrix)==true
		arr=[]
		for i in (0...matrix.length)
			for j in (0...matrix[i].length)
				sign=(-1)**(i+j)
				arr.push self::getdet(self::minor(matrix,i,j))*sign
				
			end
		end
		return AtoMatrix(arr,(matrix.length),(matrix.length))
		end
	end
	def getdet (matrix,i=0)
		if matrix==nil || matrix==[]
			matrix=@@matrix
		end
		if CM::isSquare(matrix)==true
			if CM::getSize(matrix)[0]==1
				return matrix[0][0]
			elsif CM::getSize(matrix)[0]==2
				return (matrix[0][0]*matrix[1][1]) - (matrix[0][1]*matrix[1][0])
			elsif CM::getSize(matrix)[0]==3
			return ((matrix[0][0] * matrix[1][1] * matrix[2][2]+
        			matrix[0][1] * matrix[1][2] * matrix[2][0] + 
        			matrix[0][2] * matrix[1][0] * matrix[2][1])-
        			(matrix[0][2] * matrix[1][1] * matrix[2][0] + 
        			matrix[0][0] * matrix[1][ 2] * matrix[2][1] + 
        			matrix[0][1] * matrix[1][0] * matrix[2][2]))
			else
				d=0
				for j in (0...matrix.length)
					sign=(-1)**(i+j)
					d+=(self::getdet(self::minor(matrix,i,j)))*(sign*CM::getrows(matrix,i,j))
				end
				return d
			end
		end
	end
	def transpose matrix
		arr=[]
		if matrix==nil || matrix==[]
			matrix=@@matrix
		end
		for i in (0...matrix[0].length)
			arr.push CM::getcols(matrix,i)
		end
		return arr
	end
	def adj matrix
		if matrix==nil || matrix==[]
			matrix=@@matrix
		end
		if CM::isSquare(matrix)==true
			cofactors=self::cofactors(matrix)
			return self::transpose(cofactors)
		end
	end
	def Inverse matrix
		det=getdet(matrix) if det==nil
		if det!=0
		    adj=self::adj(matrix)
		    inv=[]
            inv=CM::mulS(adj,(det)**(-1))
			return inv
		else
		    print"\e[5;90;31mNot Allowed\e[0m\n"
		    return matrix
		end
	end
	def self.mulS(matrix,s,vector=false,r=nil,c=nil)
		if vector!=true
			for i in (0...matrix.length)
				for j in (0...matrix[0].length)
					matrix[i][j]*=s
				end
			end
			return matrix
		else
			re=[]
			if r!=nil
				 for i in (0...matrix.length)
					re.push CM::getrows(matrix,r,i)*s
				end
			end
			if c!=nil
				for i in (0...matrix.length)
					re.push CM::getcols(matrix,c,i)*s
				end
			end
			return re
		end
	end
	def self.Id *size
		if size.length!=2 || size[0]!=size[1]
			print"\e[5;90;31m size:must be ordered pair and its item be equal \e[0m\n"
			return nil
		end
		if size[0]==size[1] && size!=nil
			m=CM::new()
			r=m::build(size[0])
			for i in (0...size[0])
				for j in (0...size[1])
					if i==j
						r[i][j]=1
					else
						r[i][j]=0
					end
				end
			end
			return r	
		end
	end
	def repr r1,r2
		matrix=@@matrix
		mr1=CM::getrows(matrix,r1)
		mr2=CM::getrows(matrix,r2)
		tmp=mr1
		mr1=mr2
		mr2=tmp
		matrix[r2]=mr2
		matrix[r1]=mr1
		return matrix
	end
	def repc c1,c2
		matrix=@@matrix
		mc1=CM::getcols(matrix,c1)
		mc2=CM::getcols(matrix,c2)
		tmp=mc1
		mc1=mc2
		mc2=tmp
		matrix[c2]=mc2
		matrix[c1]=mc1
		return matrix
	end
	def self.dis matrix=nil
		if matrix!=nil
			for i in (0...matrix.length)
				for j in (0...matrix[i].length)
					if i==j and CM::isSquare(matrix)
						print "\e[8;96;32m#{matrix[i][j]}\e[0m","\t"
					else
						print "\e[9;94;32m#{matrix[i][j]}\e[0m","\t"
					end
				end
				print"\n"
			end
		end
	end
	def getIndex item,matrix=nil
		index=[]
		matrix=(matrix==nil)? @@matrix:(matrix)
		for i in (0...matrix[0].length)
		    cols=CM::getcols(matrix,i)
		    index.push [cols.index(item),i] unless !cols.include?item
		end
		return (index.length==1 && index[0].length==2)? CM::MtoArray(index):index
	end
	def self.intersec matrix,r,c
		rows=CM::getrows(matrix,r)
		cols=CM::getcols(matrix,c)
		for i in rows
			for j in cols
				if i==j
					return i					
				end
			end
		end
	end
	def self.mulIntersec matrix,opts
		intsecI=[]
		done=false
		if  opts['rows'] and  opts['cols']
			for i in opts['rows']
				for j in opts['cols']
					intsecI.push self::intersec(matrix,i,j)
					done=true
				end
			end
		end
		if done==true
			return intsecI
		end
	end
	def self.mm(matrix,row=0,col=0,total=false)
	    if (row or col) and !(CM::isSquare(matrix) and total)
	        result={'rows'=>{},'cols'=>{}}
      	    r=self::getrows(matrix,row)
        	c=self::getcols(matrix,col)
            r.reduce{|a,b|result['rows']['min']= a < b ? a : b unless b==nil or a==nil}
            r.reduce{|a,b|result['rows']['max']= a > b ? a : b unless b==nil or a==nil}
            c.reduce{|a,b|result['cols']['min']= a < b ? a : b unless b==nil or a==nil}
            c.reduce{|a,b|result['cols']['max']= a > b ? a : b unless b==nil or a==nil}
            return result
	    else
	            min=self::intersec(matrix,0,0)
        	    max=self::intersec(matrix,0,0)
        	    for i in matrix
        	        for j in i
        	            if j>max
        	                max=j
        	            elsif j<min
        	                 min=j
        	            end
        	        end
        	    end
        	    return min,max
	    end
	    if (row or col) and !(CM::isSquare(matrix) and total)
	        result={'rows'=>{},'cols'=>{}}
      	    r=self::getrows(matrix,row)
        	c=self::getcols(matrix,col)
			result['rows']['min']=r.min
			result['rows']['max']=r.max
			result['cols']['min']=c.min
			result['cols']['max']=c.max
            return result
	    else
	            min=self::intersec(matrix,0,0)
        	    max=self::intersec(matrix,0,0)
        	    for i in matrix
        	        for j in i
        	            if j>max
        	                max=j
        	            elsif j<min
        	                 min=j
        	            end
        	        end
        	    end
        	    return min,max
	    end
	end
	def self.sort matrix
		for i in matrix
			r=self::getrows(matrix,i)
			r.reduce{|a,b|
				if a>b
					temp=a
					a=b
					b=temp
				else	
					temp=b				
					b=a
					a=temp
				end
				}
			matrix[i]=r	
		end
		return matrix
	end
	def getMatrix
		return @@matrix
	end
	def resMatrix matrix=nil
	    @resMatrix=matrix unless matrix==nil
	    @resMatrix
	end
	def +(other)
	    matrix=self.build(self.getMatrix.length)
		for i in (0...(other.size?[0]))
		    for j in (0...(other.size?[1]))
		        matrix[i][j]=self[i,j]+other[i,j]
		    end
		end
		self.resMatrix matrix
		return self
	end
	def -(other)
	    matrix=self.build(self.getMatrix.length)
		for i in (0...(other.size?[0]))
		    for j in (0...(other.size?[1]))
		        matrix[i][j]=self[i,j]-other[i,j]
		    end
		end
		self.resMatrix matrix
		return self
	end
	def *(other)
      res=CM::resMul
	    matrix=self::getMatrix
	    matrix2=other::getMatrix
	    r=[]
	    for i in (0...(matrix.length))
			for j in (0...(matrix[i].length))
				sum=0
				for k in (0...(matrix.length))
				    sum+=CM::rMul==0?(self[i,k]*other[k,j,res]):(self[j,k]*other[i,k,res])
				end
				r.push sum
				#@@result[i,j]=sum
			end
		end
		matrix=AtoMatrix(r,CM::getSize(matrix)[0],CM::getSize(matrix2)[1])
		self::resMatrix(matrix)
		return self
	end
	def /(other)
		matrix=self::getMatrix
	    matrix2=other::getMatrix
      inverse=!other
      CM::resMul true
      return self*inverse
	end
	def !()
	    self::resMatrix(self::Inverse(self.getMatrix))
	    return self
	end
	def **(n)
	    m=self
		_n=n>0? n:(n*-1)
		if _n==1
			return n>0?m:(!m unless !m::empty?)
		else
		    r=m*m::**(_n-1)
			n>0?r:(!r unless !r::empty?)
		end
		
	end
	def empty?
		return false unless self::getMatrix
	end
	def size?
		return CM::getSize(self::getMatrix)
	end
	def ==(other)
		equal=false
		matrix=self::getMatrix
	    matrix2=other::getMatrix
		for i in (0...(other.size?)[0])
		    for j in (0...(other.size?)[1])
		        if other[i,j]==self[i,j]
		            equal=true
		        end
		    end
		end
		return equal
		
	end
	def !=(other)
	    return !(self==other)
	end
	def <(other)
		lower=false
		matrix=self::getMatrix
	    matrix2=other::getMatrix
		for i in (0...(other.size?)[0])
		    for j in (0...(other.size?)[1])
		        if self[i,j]<other[i,j]
		            lower=true
		        end
		    end
		end
		return lower
	end
	def >(other)
		bigger=false
		matrix=self::getMatrix
	    matrix2=other::getMatrix
	    bigger=!(self<other)
		return bigger
	end
	def [] *args
	    matrix=(args[2]==true)? resMatrix: getMatrix
	    if  args[0]==nil
	        return CM::getcols(matrix,args[1])
	    elsif not args[1]
	        return CM::getrows(matrix,args[0])
	    elsif args[0] and args[1]
	        return self[nil,args[1],args[2]][args[0]]
	    end
	end
	def []= *args
	    if args[0]!=nil and args.length==1#and not args[1]
	        #@@matrix[args[0]]=args[2]
	        @@matrix[args[0]]=args[1] 
	    elsif args[0]!=nil&&args[1]!=nil
	        @@matrix[args[0]][args[1]]=args[2]
	    else
	        CM::editcols(@@matrix,args[1],args[2])
	    end
	end
	def self.>(matrix,row=true)
	    result=[]
	    if row
	        for i in (0...matrix.length)
	            result.push self::mm(matrix,i,0)['rows']['max']   
	        end
               
	    else
	        for i in (0...matrix[0].length)
	            result.push self::mm(matrix,0,i)['cols']['max']  
	        end
	    end
	    return result
	end
	def self.<(matrix,row=true)
	    result=[]
	    if row
	        for i in (0...matrix.length)
	            result.push self::mm(matrix,i,0)['rows']['min'] 
	        end
               
	    else
	        for i in (0...matrix[0].length)
	            result.push self::mm(matrix,0,i)['cols']['min']  
	        end
	    end
	    return result
	end
	def self.editcols matrix,oldIndex,newValue
		edit=false
		cols=self::getcols(matrix,oldIndex)
		for i in (0...cols.length)
			edit=true if matrix[i][oldIndex]=newValue[i]
		end
		return edit
	end
       def _*_s(s,vector=false,r=nil,c=nil)
	 self.resMatrix(self.mulS(getMatrix,vector,r,c))
	 self.resMatrix
	end
end
