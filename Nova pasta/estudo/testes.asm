.text
START:
	li a0, 23
	li a1, 25
	jal MAIN
	li a7, 10
	ecall
MAIN:	
	beq a0, a1, END
	bge a0, a1, CASO_1
	sub a1, a1, a0
	j MAIN
	CASO_1:
	sub a0, a0, a1
	j MAIN
	END:
	ret
