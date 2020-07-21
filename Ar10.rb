def block_init (*args)
	return args;
end

def test &person	
yield(block_init("Abdo",20.5,"student"));
end
#puts test {|str,float,job|  {"Name"=>str,"Age"=>float,"job"=>job}}
#anonymous-functions:
	#lambda= -> (name){puts "Hello #{name}"} #arrow-function
	#lambda.call("Abdo");
	#proc=Proc.new {|name| puts "#{name}"}
	#proc.call("Abdo")