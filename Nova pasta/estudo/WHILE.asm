MAIN:
	li t0, 0	#a = 0
	li t1, 10	#temp = 10
WHILE:	beq t0, t1, END	#se t0 == t1 pule para END (while(a <= 10)) 
	addi t0, t0, 1	#a += 1
	j WHILE
END:
	li a7, 10
	ecall