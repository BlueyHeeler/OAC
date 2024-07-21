.data
STRING: .string "Soma: "
.text
MAIN:
	li s0, 10		#t0 = 10
	addi sp, sp, -40	#alocando 10 word na pilha
WHILE:			
	beq s0, zero, NEXT	#if t0, zero, NEXT
	li a7, 5		
	ecall
	sw a0, 0(sp)		#salvando na pilha
	addi sp, sp, 4		#subindo na pilha
	addi s0, s0, -1		#t0 -= 1
	j WHILE
	
NEXT:
	addi sp, sp, -40
	li s0, 10		#t0 = 10
	mv a3, zero		#a3 = 0
WHILE_2:
	beq s0, zero, END	#if t0, zero, END
	lw a0, 0(sp)		#load word sp
	addi sp, sp, 4		#subindo na pilha
	addi s0, s0, -1		# t0 -=1
	jal TESTA_5
	bne a1, zero, WHILE_2
	add a3, a3, a0 
	j WHILE_2
	
TESTA_5:
	li t0, 5
	rem a1, a0, t0 
	ret

END:
	la a0, STRING
	li a7, 4
	ecall
	mv a0, a3
	li a7, 1
	ecall
	li a7, 10
	ecall
		
		