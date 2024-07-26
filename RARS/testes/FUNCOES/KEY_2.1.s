.text
KEY2.1:		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,DEFAULT   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'W'
		beq t2,t0,CIMA			# se tecla pressionada for 'w', va CHAR_CIMA

		li t0,'A'
		beq t2,t0,ESQUERDA		# se tecla pressionada for 'a', va CHAR_CIMA
		
		li t0,'S'
		beq t2,t0,BAIXO			# se tecla pressionada for 's', va CHAR_CIMA
		
		li t0,'D'
		beq t2,t0,DIREITA		# se tecla pressionada for 'd', va CHAR_CIMA
		
		li t0,'w'
		beq t2,t0,CIMA_w			# se tecla pressionada for 'w', va CHAR_CIMA

		li t0,'a'
		beq t2,t0,ESQUERDA_a		# se tecla pressionada for 'a', va CHAR_CIMA
		
		li t0,'s'
		beq t2,t0,BAIXO_b		# se tecla pressionada for 's', va CHAR_CIMA
		
		li t0,'d'
		beq t2,t0,DIREITA_d		# se tecla pressionada for 'd', va CHAR_CIMA
		
		li t0,'o'		
		beq t2, t0,MOV_ESQ		# se tecla pressionada for 'o', va MOV_ESQ
		
		li t0,'p'
		beq t2,t0,MOV_DIR		# se tecla pressionada for 'p', va MOV_DIR
		
		li t0, 'g'			# se tecla pressionada for 'g', va GROW
		beq t2, t0, GROW
		
		li t0, 'g'			# se tecla pressionada for 'G', va GROW
		beq t2, t0, GROW
		
		li t0, 'h'			# se tecla pressionada for 'h', va HALF
		beq t2, t0, HALF
		
		li t0, 'H'			# se tecla pressionada for 'h', va HALF
		beq t2, t0, HALF
		
		li t0,'O'		
		beq t2, t0,MOV_ESQ		# se tecla pressionada for 'o', va MOV_ESQ
		
		li t0,'P'
		beq t2,t0,MOV_DIR		# se tecla pressionada for 'p', va MOV_DIR
		
		li t0,'u'			# se tecla pressionada for 'u' va EXIT
		beq t2,t0,EXIT
		
		li t0,'f'			# se tecla pressionada for 'f' va SHOOT
		beq t2, t0, SHOOT
	
DEFAULT:		
		mv t0, zero
		mv t1, zero
		mv t2, zero
		mv t3, zero
		mv t4, zero
		mv t5, zero
		ret				# retorna
		
CIMA:		
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		beq t0, zero, FIM
		#CIMA PARTE SUPERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_UP	#endereco de CHAR_POS_UP
		li t3, 16		#carrega 8 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR est 
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR est 
		#agora t4 contem a posicao do CHAR_POS em relacao a matriz
		#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, -16	#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, 16
		beq t3, t5, GAME_LOOP	#v  para GAME_LOOP
		#===============================================================#
		addi sp, sp, -20	#alocando pilha
		sw t0, 0(sp)
		sw t1, 4(sp)
		sw t2, 8(sp)
		sw t3, 12(sp)
		sw t4, 16(sp)
		#================================================================#
		#CIMA PARTE INFERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_DOWN	#endereco de CHAR_POS_UP
		li t3, 16		#carrega 8 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR est 
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR est 
		#agora t4 contem a posicao do CHAR_POS em relacao a matriz
		#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, -16	#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, 16
		beq t3, t5, GAME_LOOP	#v  para GAME_LOOP
		#Não há colisão na PARTE SUPERIOR NEM NA PARTE INFERIOR
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, -16	#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 0(t2)		#carrega o y em t3
		addi t3, t3, -1		#decrementa um em t3
		sh t3, 0(t2)		#novo CHAR_POS
		lw t0, 0(sp)
		lw t1, 4(sp)
		lw t2, 8(sp)
		lw t3, 12(sp)
		lw t4, 16(sp)
		addi sp, sp, 20
		li t3, 2		#carrega 2 em t3
		addi t0, t0, -16	#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 0(t2)		#carrega o y em t3
		addi t3, t3, -1		#decrementa um em t3
		sh t3, 0(t2)		#novo CHAR_POS
		j FIM

BAIXO:
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		beq t0, zero, FIM
		#BAIXO SUPERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_UP	#endereco de CHAR_POS
		li t3, 16		#carrega 8 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR está
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR está
		#agora t4 contém a posição do CHAR_POS em relação a matriz
		#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, 16		#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, -16
		#====================================================================#
		beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
		addi sp, sp, -24
		sw ra, 0(sp)
		sw t0, 4(sp)
		sw t1, 8(sp)
		sw t2, 12(sp)
		sw t3, 16(sp)
		sw t4, 20(sp)
		#===================================================================#
		#BAIXO INFERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_DOWN	#endereco de CHAR_POS
		li t3, 16		#carrega 8 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR está
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR está
		#agora t4 contém a posição do CHAR_POS em relação a matriz
		#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, 16		#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, -16
		beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
		jal ITEM_1
		#===================================================================#
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, 16		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 0(t2)		#carrega o y em t3
		addi t3, t3, 1		#decrementa um em t3
		sh t3, 0(t2)		#novo CHAR_POS
		lw ra, 0(sp)
		lw t0, 4(sp)
		lw t1, 8(sp)
		lw t2, 12(sp)
		lw t3, 16(sp)
		lw t4, 20(sp)
		addi sp, sp, 24
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, 16		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 0(t2)		#carrega o y em t3
		addi t3, t3, 1		#decrementa um em t3
		sh t3, 0(t2)		#novo CHAR_POS
		
		j FIM

ESQUERDA:
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		beq t0, zero, FIM
		#ESQUERDA SUPERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_UP	#endereco de CHAR_POS
		li t3, 16		#carrega 4 em t3
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
		#====================================================================#
		beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
		addi sp, sp, -24
		sw ra, 0(sp)
		sw t0, 4(sp)
		sw t1, 8(sp)
		sw t2, 12(sp)
		sw t3, 16(sp)
		sw t4, 20(sp)
		#===================================================================#
		#ESQUERDA INFERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_DOWN	#endereco de CHAR_POS
		li t3, 16		#carrega 4 em t3
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
		li t5, 3
		jal ITEM_1	
		#nao ha colisao nem na parte superior nem na inferior
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, -1		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 2(t2)		#carrega o x em t3
		addi t3, t3, -1		#decrementa um em t3
		sh t3, 2(t2)		#novo CHAR_POS
		lw ra, 0(sp)
		lw t0, 4(sp)
		lw t1, 8(sp)
		lw t2, 12(sp)
		lw t3, 16(sp)
		lw t4, 20(sp)
		addi sp, sp, 24
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, -1		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 2(t2)		#carrega o x em t3
		addi t3, t3, -1		#decrementa um em t3
		sh t3, 2(t2)		#novo CHAR_POS
		j FIM
	
DIREITA:
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		beq t0, zero, FIM
		#DIREITA SUPERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_UP	#endereco de CHAR_POS
		li t3, 16		#carrega 4 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR est 
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR est 
		#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, 1		#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, -1
		#====================================================================#
		beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
		addi sp, sp, -24
		sw ra, 0(sp)
		sw t0, 4(sp)
		sw t1, 8(sp)
		sw t2, 12(sp)
		sw t3, 16(sp)
		sw t4, 20(sp)
		#===================================================================#
		#DIREITA INFERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_DOWN	#endereco de CHAR_POS
		li t3, 16		#carrega 4 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR est 
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR est 
		#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, 1		#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, -1
		beq t3, t5, GAME_LOOP	#v  para GAME_LOOP
		li t5, 3
		jal ITEM_1
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, 1		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 2(t2)		#carrega o x em t3
		addi t3, t3, 1		#decrementa um em t3
		sh t3, 2(t2)		#novo CHAR_POS
		lw ra, 0(sp)
		lw t0, 4(sp)
		lw t1, 8(sp)
		lw t2, 12(sp)
		lw t3, 16(sp)
		lw t4, 20(sp)
		addi sp, sp, 24
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, 1		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 2(t2)		#carrega o x em t3
		addi t3, t3, 1		#decrementa um em t3
		sh t3, 2(t2)		#novo CHAR_POS
		j FIM

MOV_ESQ:	la t0, POS_MAPA		#endereco da posicao do mapa
		lh t1, 0(t0)		#valor do endereco
		li t2, 0		#t2 = 0
		beq t1, t2, GAME_LOOP	#se t1 == t2   porque est  na borda e o mapa n o pode ir mais pra esquerda
		addi t1, t1, -1		#caso contrario
		sh t1, 0(t0)		#salvando no endereco da posicao do mapa
		j FIM

MOV_DIR:	la t0, POS_MAPA		#endereco da posicao do mapa
		lh t1, 0(t0)		#valor do endereco
		addi t1, t1, 8		#
		li t2, 16		#t2 = 0
		beq t1, t2, GAME_LOOP	#se t1 == t2   porque est  na borda e o mapa n o pode ir mais pra esquerda
		addi t1, t1, -8		
		addi t1, t1, 1		#caso contr rio
		sh t1, 0(t0)		#salvando no endereco da posicao do mapa
		j FIM
GROW:		
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		li t1, 1
		beq t0, t1, FIM
		la t0, PEQUENO_GRANDE
		li t1, 1
		sb t1, 0(t0)
		#CIMA PARTE SUPERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_UP	#endereco de CHAR_POS_UP
		li t3, 16		#carrega 8 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR est 
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR est 
		#agora t4 contem a posicao do CHAR_POS em relacao a matriz
		#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, -16	#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, 16
		beq t3, t5, GAME_LOOP	#v  para GAME_LOOP
		li t3, 2		#carrega 2 em t3
		addi t0, t0, -16	#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 0(t2)		#carrega o y em t3
		addi t3, t3, -1		#decrementa um em t3
		sh t3,0(t2)
		j FIM
		
HALF:		
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		beq t0, zero, FIM
		la t0, ITEM_1_BYTE
		lb t0, 0(t0)
		beq t0, zero, FIM
		la t0, PEQUENO_GRANDE
		sb zero, 0(t0)
		#BAIXO PARTE SUPERIOR
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_UP	#endereco de CHAR_POS
		li t3, 16		#carrega 8 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR est 
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR est 
					#agora t4 cont m a posi  o do CHAR_POS em rela  o a matriz
					#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, 16		#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, -16
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, 16		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 0(t2)		#carrega o y em t3
		addi t3, t3, 1		#decrementa um em t3
		sh t3, 0(t2)		#novo CHAR_POS
		j FIM

CIMA_w:		
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		li t1, 1
		beq t0, t1, FIM
		#CIMA
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_DOWN	#endereco de CHAR_POS
		li t3, 16		#carrega 16 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR está
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR está
					#agora t4 contém a posição do CHAR_POS em relação a matriz
					#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, -16	#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, 16		#voltando pro endereco antigo(vai servir para cobrir o "rastro")
		beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, -16		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 0(t2)		#carrega o y em t3
		addi t3, t3, -1		#decrementa um em t3
		sh t3, 0(t2)		#novo CHAR_POS
		la t2, CHAR_POS_UP
		sh t3, 0(t2)
		j FIM

BAIXO_b:
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		li t1, 1
		beq t0, t1, FIM
		#BAIXO
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_DOWN	#endereco de CHAR_POS
		li t3, 16		#carrega 8 em t3
		lh t4, 0(t2)		#carrega o y em t4
		mul t4, t4, t3		#em qual linha o CHAR está
		lh t3, 2(t2)		#carrega o x em t3
		add t4, t4, t3		#em qual coluna o CHAR está
					#agora t4 contém a posição do CHAR_POS em relação a matriz
		#procedimento que averigua colisao
		add t0, t0, t4		#endereco do CHAR_POS na matriz
		addi t0, t0, 16		#novo endereco do CHAR_POS na matriz
		lb t3, 0(t0)		#carrega o valor de CHAR_POS da matriz
		li t5, 1 		#t5 = 1
		addi t0, t0, -16
		beq t3, t5, GAME_LOOP	#vá para GAME_LOOP
		#fim do procedimento que averigua colisao
		li t3, 0		#carrega 0 em t3
		sb t3, 0(t0)		#colocando 0 no endereco
		li t3, 2		#carrega 2 em t3
		addi t0, t0, 16		#novo endereco do CHAR_POS na matriz
		sb t3, 0(t0)		#colocando 2 no endereco
		lh t3, 0(t2)		#carrega o y em t3
		addi t3, t3, 1		#decrementa um em t3
		sh t3, 0(t2)		#novo CHAR_POS
		la t2, CHAR_POS_UP
		sh t3, 0(t2)
		j FIM

ESQUERDA_a:	
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		li t1, 1
		beq t0, t1, FIM
		#ESQUERDA
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_DOWN	#endereco de CHAR_POS
		li t3, 16		#carrega 4 em t3
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
		la t2, CHAR_POS_UP
		sh t3, 2(t2)
		j FIM
	
DIREITA_d:	#verificação se o personagem esta pequeno ou grande
		la t0, PEQUENO_GRANDE	#endereco do pequeno ou grande
		lb t0, 0(t0)		#carregando o byte de t0
		li t1, 1		#t1 = 1
		beq t0, t1, FIM		#if t0 == t1, ou seja, se o char estiver grande FIM
		#DIREITA
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS_DOWN	#endereco de CHAR_POS
		li t3, 16		#carrega 4 em t3
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
		la t2, CHAR_POS_UP
		sh t3, 2(t2)
		j FIM

SHOOT:
		la t0, PEQUENO_GRANDE
		lb t0, 0(t0)
		beq t0, zero, FIM
		
		

ITEM_1:
	li t5, 3
	beq t3, t5, TEM_ITEM_1
	ret
	
TEM_ITEM_1:
	la a0, ITEM_1_BYTE
	li a1, 1
	sb a1, 0(a0)
	ret
FIM:
	mv a0, zero
	mv a1, zero
	mv t0, zero
	mv t1, zero
	mv t2, zero
	mv t3, zero
	mv t4, zero
	mv t5, zero
	ret
EXIT:
		li a7, 10
		ecall
