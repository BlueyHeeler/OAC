.text
MAIN:	
	li a7, 5
	ecall
	mv t0,a0	#t0 = multiplicando
	li a7, 5
	ecall
	mv t1, a0	#t1 = multiplicador
	li t3, 0	#t3 = 0
	li t4, 32	#t4 = 32
	mv a0, zero
	li a2, 1

WHILE:
	beq t3, t4, END  #if t3 == t4 end
	and a1, t1, a2	 #a1 = 0 or a1 = 1(Verifica o LSB do multiplicador)
	addi t3, t3, 1	 #t3 += 1
	beq a1, a2, SOMAR#if a1 == 1, SOMAR
	slli t0, t0, 1 	 #shift left logical de t0
	srli t1, t1, 1	 #shift righ logical de t1
	j WHILE
SOMAR:
	add a0, a0, t0	 #adiciona o multiplicando ao produto
	slli t0, t0, 1 	 #shift left logical de t0
	srli t1, t1, 1	 #shift righ logical de t1
	j WHILE
	
END:
	li a7, 36
	ecall
	li a7, 10
	ecall