with open("NT.out") as file:
	for line in file.readlines():
		start = line.find('$NT$') +4
		end = line.find(':S-1')
		hash = line[start:end]
		print(hash)
	