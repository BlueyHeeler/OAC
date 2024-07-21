MAIN:
	li t0, 3		#a = 3
	li t1, 1		#temp = 1
	bne t0, t1, CASE2	#se a != temp pule para CASE2
	#a == temp
	li s0, 12		#b = 12
	j END			#pule para END
CASE2:
	li t1, 2		#temp = 2
	bne t0, t1, CASE3	# se a!= temp pule para CASE3
	#a == temp
	li s0, 14		#b = 14
	j END			#pule para END
CASE3:
	li t1, 3		#temp = 3
	bne t0, t1, DEFAULT	#se a!= temp pule para DEFAULT
	#a == temp
	li s0, 16		#b = 16
	j END			#pule para END
DEFAULT:			
	li s0, -1		#b = -1
	
END:
	li a7, 10		#chamada de saída do sistema
	ecall