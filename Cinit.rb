load"Ciphers.rb"
RSA::initW("attack at seven")
k=#[259, 61, 85, 216]#[4553, 209, 209, 4368]
print"\e[0;96;32m#{k=RSA::initKey(8)}\e[0m\n"
puts"\e[8;90;31m#{RSA::enc(k)}\e[0m\n"
puts"\e[8;90;30m#{RSA::dec(k)}\e[0m\n"
'''k=[[889, 125, 629, 756],[2629, 19, 1879, 2380],[1665, 35, 1403, 1584],[561, 187, 3, 112],[1467, 97, 481, 1296]]#ex
for i in k
	puts"\e[8;90;31m#{RSA::enc(i)}\e[0m\n"
	puts"\e[8;90;30m#{RSA::dec(i)}\e[0m\n"
end'''