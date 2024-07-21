	#IF THEN ELSE
MAIN:
	li t0, 0		# a = 0
	beq t0, zero, THEN	# if a = 0 pule para THEN
	jal ELSE
	li t0, 1		# a = 1
	li a7, 10		#chamada de saída do sistema
	ecall
	
THEN:	li t1, 5		#b = 5
	li a7, 10		#chamada de saída do sistema
	ecall			

ELSE:	li t1, 10		#b = 10
	ret			#retorna para o "jal ELSE"