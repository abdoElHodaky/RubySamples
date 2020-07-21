@array=(1,5,6,9,-1,1,0,2,8);#declare array
%hash=(1,1,2,4,3,6);#declare hash
#view array
for ($var = 0; $var < @array.length; $var++) {
	print $array[$var],"\n"
}
print"\n\n";
#view hash
for (my $var = 1; $var < %hash.length; $var++) {
	print $hash{$var},"\n"
}
#view hashes => $+hashvarName +{key}
#view arrays => $+arraysvarName+[index/key]
@arrays=(1,(2,4,6,8,10),3,5,7,9,11);
foreach my $x (@arrays) {
	print $x,"\n"
}
print"\n\n";
sub Add {
	my($x,$y)=@_;#get arguments
	return $x+$y;
}
#call functions functionname() or ((&) functionname())=>subroutine 
print &Add(5,2);