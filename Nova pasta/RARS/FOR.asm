.data
.include "Mapa_and_Sprites.asm"
ESPACO : .string " "
PULAR : .string "\n"
.text
START:
	la t0, background	#carrega o endereco de backgroun em t0
	lw t1, 0(t0)		#t1 = largura
	lw t2, 4(t0)		#t2 = altura
	mul t3, t1, t2		#t3 = largura * altura
	addi t3, t3, -1		#t3 -= 1
	addi t0, t0, 8		#t0 += 8 pular as words de largura e altura7
	mv t4, zero		#contador de largura
	mv t5, zero		#contador de altura
	jal WHILE
	
	li a7, 10
	ecall
WHILE:
	beq t1, t4, PULAR_LINHA	#Se o contador de largura for igual a largura pule uma linha
	j ITERACOES

PULAR_LINHA:
	li t4, 0		#resetando o contador de largura
	#la a0, PULAR
	#li a7, 4
	#ecall
	addi t5, t5, 1
	beq t5, t2, END
	j ITERACOES

ITERACOES:
	lb a0, 0(t0)
	li a7, 1
	ecall
	la a0, ESPACO
	#li a7, 4
	#ecall
	addi t0, t0, 1
	addi t4, t4, 1
	j WHILE
END:
	ret
	
	
	
	
	
	
