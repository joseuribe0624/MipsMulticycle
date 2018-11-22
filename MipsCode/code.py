print("mostrar mensaje set0 o set1")
count = 0
entrada=input("arriba o abajo")
circuit=[]
circuits=[]
while entrada != enter:
	if entrada=="up": 
		print("circuito de ejercicios")
		entrada=input("arriba o abajo")
		mmss=0
		while mmss != 2:
			if entrada=="up": 
				if count + 1 > 59:
					count=0
				else:
					count = count+1

			elif entrada == "down":
				if count - 1 < 0:
					count=59
				else:
					count = count-1
			
			elif entrada == "enter":
				circuit.push(count)
				mmss+=1
			print(count)

	elif entrada == "down":
		print("circuito de descanso")
		entrada=input("arriba o abajo")
		mmss=0
		while mmss != 2:
			if entrada=="up": 
				if count + 1 > 59:
					count=0
				else:
					count = count+1

			elif entrada == "down":
				if count - 1 < 0:
					count=59
				else:
					count = count-1
			
			elif entrada == "enter":
				circuit.push(count)
				mmss+=1
			print(count)

circuits.push(circuit)
		
