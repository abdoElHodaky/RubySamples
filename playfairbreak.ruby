# cook your code here
key=[*('a'..'z')].shuffle
key.delete('j')
cipher=word="knead"
#word=cipher+key[-1] unless cipher.length%2==0
for k in key
  word+=k unless cipher.include?k
end
p word.length