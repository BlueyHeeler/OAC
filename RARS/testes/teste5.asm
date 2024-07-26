.data
.include "script\Imagens\imagens_convertidas\arquivos .data\mini_background.data"
.include "script\Imagens\imagens_convertidas\arquivos .data\background.data"
espaco:
    	.asciz " "
pular:
	.asciz "\n"
CHAR_POS:	.half 2, 1

.text
START:
	jal PRINT_MATRIZ

GAME_LOOP:	
	li a7, 12
	ecall
	mv s0, a0
	la a0, pular
	li a7, 4
	ecall
	la t0, background	#endereco do mini_background
	addi t0, t0, 8		#pula a largura e a altura
	
	#MOVIMENTAÇÃO
	li t1, 'w'
	bne s0, t1, BAIXO
	#CIMA
	la t2, CHAR_POS		#endereco de CHAR_POS
	li t3, 8		#carrega 4 em t3
	lh t4, 0(t2)		#carrega o y em t4
	mul t4, t4, t3		#em qual linha o CHAR está
	lh t3, 2(t2)		#carrega o x em t3
	add t4, t4, t3		#em qual coluna o CHAR está
				#agora t4 contém a posição do CHAR_POS em relação a matriz
	#procedimento que averigua colisao
	add t0, t0, t4		#endereco do CHAR_POS na matriz
	addi t0, t0, -8		#novo endereco do CHAR_POS na matriz
	lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
	li t5, 1 		#t5 = 1
	addi t0, t0, 8
	beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
	li t3, 0		#carrega 0 em t3
	sb t3, 0(t0)		#colocando 0 no endereco
	li t3, 2		#carrega 2 em t3
	addi t0, t0, -8		#novo endereco do CHAR_POS na matriz
	sb t3, 0(t0)		#colocando 2 no endereco
	lh t3, 0(t2)		#carrega o y em t3
	addi t3, t3, -1		#decrementa um em t3
	sh t3, 0(t2)		#novo CHAR_POS
	jal PRINT_MATRIZ
	j GAME_LOOP
	
BAIXO:
	li t1, 's'
	bne s0, t1, ESQUERDA
	#BAIXO
	la t2, CHAR_POS		#endereco de CHAR_POS
	li t3, 8		#carrega 4 em t3
	lh t4, 0(t2)		#carrega o y em t4
	mul t4, t4, t3		#em qual linha o CHAR está
	lh t3, 2(t2)		#carrega o x em t3
	add t4, t4, t3		#em qual coluna o CHAR está
				#agora t4 contém a posição do CHAR_POS em relação a matriz
	#procedimento que averigua colisao
	add t0, t0, t4		#endereco do CHAR_POS na matriz
	addi t0, t0, 8		#novo endereco do CHAR_POS na matriz
	lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
	li t5, 1 		#t5 = 1
	addi t0, t0, -8
	beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
	#fim do procedimento que averigua colisao
	li t3, 0		#carrega 0 em t3
	sb t3, 0(t0)		#colocando 0 no endereco
	li t3, 2		#carrega 2 em t3
	addi t0, t0, 8		#novo endereco do CHAR_POS na matriz
	sb t3, 0(t0)		#colocando 2 no endereco
	lh t3, 0(t2)		#carrega o y em t3
	addi t3, t3, 1		#decrementa um em t3
	sh t3, 0(t2)		#novo CHAR_POS
	jal PRINT_MATRIZ
	j GAME_LOOP

ESQUERDA:
	li t1, 'a'
	bne s0, t1, DIREITA
	#ESQUERDA
	la t2, CHAR_POS		#endereco de CHAR_POS
	li t3, 8		#carrega 4 em t3
	lh t4, 0(t2)		#carrega o y em t4
	mul t4, t4, t3		#em qual linha o CHAR está
	lh t3, 2(t2)		#carrega o x em t3
	add t4, t4, t3		#em qual coluna o CHAR está
				#agora t4 contém a posição do CHAR_POS em relação a matriz
	#procedimento que averigua colisao
	add t0, t0, t4		#endereco do CHAR_POS na matriz
	addi t0, t0, -1		#novo endereco do CHAR_POS na matriz
	lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
	li t5, 1 		#t5 = 1
	addi t0, t0, 1
	beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
	
	li t3, 0		#carrega 0 em t3
	sb t3, 0(t0)		#colocando 0 no endereco
	li t3, 2		#carrega 2 em t3
	addi t0, t0, -1		#novo endereco do CHAR_POS na matriz
	sb t3, 0(t0)		#colocando 2 no endereco
	lh t3, 2(t2)		#carrega o x em t3
	addi t3, t3, -1		#decrementa um em t3
	sh t3, 2(t2)		#novo CHAR_POS
	jal PRINT_MATRIZ
	j GAME_LOOP
	
DIREITA:
	li t1, 'd'
	bne s0, t1, DEFAULT
	#DIREITA
	la t2, CHAR_POS		#endereco de CHAR_POS
	li t3, 8		#carrega 4 em t3
	lh t4, 0(t2)		#carrega o y em t4
	mul t4, t4, t3		#em qual linha o CHAR está
	lh t3, 2(t2)		#carrega o x em t3
	add t4, t4, t3		#em qual coluna o CHAR está
	#agora t4 contém a posição do CHAR_POS em relação a matriz
	#procedimento que averigua colisao
	add t0, t0, t4		#endereco do CHAR_POS na matriz
	addi t0, t0, 1		#novo endereco do CHAR_POS na matriz
	lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
	li t5, 1 		#t5 = 1
	addi t0, t0, -1
	beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
	
	li t3, 0		#carrega 0 em t3
	sb t3, 0(t0)		#colocando 0 no endereco
	li t3, 2		#carrega 2 em t3
	addi t0, t0, 1		#novo endereco do CHAR_POS na matriz
	sb t3, 0(t0)		#colocando 2 no endereco
	lh t3, 2(t2)		#carrega o x em t3
	addi t3, t3, 1		#decrementa um em t3
	sh t3, 2(t2)		#novo CHAR_POS
	jal PRINT_MATRIZ
	j GAME_LOOP

DEFAULT:
	li a7, 10
	ecall

PRINT_MATRIZ:	la t0, background	#carrega o endereco do background
		lw t1, 0(t0)		#carrega a largura
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
		la a0, pular
		li a7, 4
		ecall
		j ITERACOES		
ITERACOES:	lb t3, 0(t0)		#guarda os bytes de background em t3
		add a0, t3, zero	#a0 = t3 
		li a7, 1		
		ecall
		la a0, espaco
		li a7, 4
		ecall
		addi t0, t0, 1		#t0 += 1
		addi t4, t4, 1		#t4 += 1
		addi s0, s0 ,1
		j WHILE
END:
		la a0, pular
		li a7, 4
		ecall
		ret
