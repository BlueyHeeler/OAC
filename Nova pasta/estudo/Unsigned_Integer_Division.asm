.data
QUOCIENTE: .string "Quociente: "
RESTO: .string "Resto: "
PULAR: .asciz "\n"

.text
MAIN:
	li a7, 5
	ecall
	mv t0, a0	#t0 = dividendo(Q)
	li a7, 5
	ecall
	mv t1, a0	#t1 = divisor(M)
	bgeu t1, t0, END_2
	lui s0, 0x80000	#número de 32 bits com 1 no bit mais significativo
	mv t2, zero 	#t2 = resto(A)
	neg t1, t1	#t1 = -t1
	li t3, 32	#t3 = 0
WHILE:
	beq zero, t3, END	#if t3 == 0, END
	addi sp, sp, -4		#alocando espaco na pilha
	slli t2, t2, 1		#shift left de t2(A)
	and a0, s0, t0		#a0 possui o bit MSB de t0(Q)
	srli a0, a0, 31		#colocando a0 no bit menos significativo 
	slli t0, t0, 1		#shift left de t0(Q)
	add t2, t2, a0		#colocando o MSB de t0 no LSB de t2(A)
	sw t2, 0(sp)		#salvando t2(A) na pilha
	add t2, t2, t1		#t2(A) = t2(A) - t1(M)
	and a0, s0, t2		#a0 possui o MSB de t2(A)
	srli a0, a0, 31		#colocando a0 no bit menos significativo 
	beq a0, zero, CASO_1
	j CASO_2
CASO_1:
	addi sp, sp, 4		#desalocando pilha
	addi t0, t0, 1		#colocando 1 no LSB de t0(Q)
	addi t3, t3, -1		#t3 -= 1
	j WHILE
CASO_2:
	lw t2, 0(sp)		#Restaurando t2(A)
	addi sp, sp, 4		#desalocando pilha
	addi t3, t3, -1		#t3 -= 1
	j WHILE

END:
	la a0, QUOCIENTE
	li a7, 4
	ecall
	
	mv a0, t0
	li a7, 1
	ecall
	
	la a0, PULAR
	li a7, 4
	ecall
	
	la a0, RESTO
	li a7, 4
	ecall
	
	mv a0, t2
	li a7, 36
	ecall
	
	li a7, 10
	ecall

END_2:
	la a0, QUOCIENTE
	li a7, 4
	ecall
	
	li a0, 0
	li a7, 1
	ecall
	
	la a0, PULAR
	li a7, 4
	ecall
	
	la a0, RESTO
	li a7, 4
	ecall
	
	mv a0, t0
	li a7, 36
	ecall
	
	li a7, 10
	ecall