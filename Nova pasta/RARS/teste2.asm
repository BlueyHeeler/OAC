.data
.include "MAPA\background.s"

.text
PRINT_MATRIZ:	la t0, background	#carrega o endereco do background
		li t1, 8		#carrega a largura
		addi t1, t1, 1
		lw t2, 4(t0)		#carrega a altura
		addi t0, t0, 8		#pula a largura e a altura
		li t4, 1		#t4 = 0
		li t5, 1		#t5 = 1
		mv s0, zero
		
WHILE:		beq t4, t1, CASO_1	#t4 = t1 ? caso sim pule para caso_1
		j ITERACOES		#caso não pule para iteracoes
CASO_1:		beq t5, t2, END		#t5 = t2 ? caso sim pule para end
		addi t5, t5, 1		#t5 += 1
		li t4, 1		#t4 = 1
		j ITERACOES		
ITERACOES:	lb t3, 0(t0)		#guarda os bytes de background em t3
		add a0, t3, zero	#a0 = t3 
		li a7, 1		
		ecall
		addi t0, t0, 1		#t0 += 1
		addi t4, t4, 1		#t4 += 1
		addi s0, s0 ,1
		j WHILE
END:
		li a7, 10
		ecall
