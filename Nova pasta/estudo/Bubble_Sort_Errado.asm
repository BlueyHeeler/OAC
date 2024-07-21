.data
.space 40				#guardando 10 espa�os pros n�meros
espaco: .asciz " "			#espaco
pular: .asciz "\n"			#pular linha
.text 
MAIN:
	li s0, 0x10010000		#primeiro endere�o da mem�ria
	li t0, 10			#a = 10
	WHILE:				#while(a--)
		li a7, 5		#leitura de int (carrega em a0)
		ecall			
		sw a0, 0(s0)		#guardando o int na mem�ria
		addi s0, s0, 4		#pr�ximo espa�o da mem�ria
		addi t0, t0, -1		#a -= 1
		bnez t0, WHILE		#se a for diferente de 0 pule para WHILE
		
	#Realizarei um bubble sort O(n�).
	li s0, 0x10010000		#primeiro endere�o da mem�ria
	li t0, 10			#a = 10
	SORT:	
		li s0, 0x10010000	#primeiro endere�o da mem�ria
		li t1, 9 		#b = 10
		WHILE2: 
			lw t3,0(s0)	#c = v[0+n]
			lw t4,4(s0)	#d = v[1+n]
			blt t3, t4,NADA #se c < d fa�a nada
			sw t4,0(s0)	#troca
			sw t3,4(s0)	#troca
			NADA:
			addi s0, s0, 4	#pr�ximos endere�os
			addi t1, t1, -1 #b -= 1
			bnez t1, WHILE2	#se b for difente de 0 pule para WHILE
			
		addi t0, t0 , -1	#a -= 1
		bnez t0, SORT		#se a for diferente de 0 pule para SORT
		
	li s0, 0x10010000		#endereco inicial da mem�ria
	li t0, 10			#a = 10
	WHILE3:
		lw a0, 0(s0)		#carrega em a0 o primeiro endereco da mem�ria
		li a7, 1		#print int
		ecall
		la a0, espaco		#carrega em a0 o espaco
		li a7, 4		#print string
		ecall
		addi s0, s0, 4		#pr�ximo endere�o
		addi t0, t0, -1		#a -= 1
		bnez t0, WHILE3		#se a for diferente de 0 pule para WHILE3
	la a0, pular
	li a7, 4
	ecall
	li a7, 10
	ecall