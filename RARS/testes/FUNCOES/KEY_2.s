.text
KEY2:		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'w'
		beq t2,t0,CIMA			# se tecla pressionada for 'w', chama CHAR_CIMA
		
		li t0,'a'
		beq t2,t0,ESQUERDA		# se tecla pressionada for 'a', chama CHAR_CIMA
		
		li t0,'s'
		beq t2,t0,BAIXO			# se tecla pressionada for 's', chama CHAR_CIMA
		
		li t0,'d'
		beq t2,t0,DIREITA		# se tecla pressionada for 'd', chama CHAR_CIMA
		
		li t0,'o'		
		beq t2, t0,MOV_ESQ		# se tecla pressionada for 'o', chama MOV_ESQ
		
		li t0,'p'
		beq t2,t0,MOV_DIR		# se tecla pressionada for 'p', chama MOV_DIR
		
		li t0,'u'
		beq t2,t0,EXIT
	
FIM:		
		mv t0, zero
		mv t1, zero
		mv t2, zero
		mv t3, zero
		mv t4, zero
		mv t5, zero
		ret				# retorna
		
CIMA:		
		#CIMA
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS		#endereco de CHAR_POS
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
		ret

BAIXO:
		#BAIXO
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS		#endereco de CHAR_POS
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
		ret

ESQUERDA:
		#ESQUERDA
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS		#endereco de CHAR_POS
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
		ret
	
DIREITA:
		#DIREITA
		la t0, background2	#endereco do mini_background
		addi t0, t0, 8		#pula a largura e a altura
		la t2, CHAR_POS		#endereco de CHAR_POS
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
		ret

MOV_ESQ:	la t0, POS_MAPA		#endereco da posicao do mapa
		lh t1, 0(t0)		#valor do endereco
		li t2, 0		#t2 = 0
		beq t1, t2, GAME_LOOP	#se t1 == t2 é porque está na borda e o mapa não pode ir mais pra esquerda
		addi t1, t1, -1		#caso contrário
		sh t1, 0(t0)		#salvando no endereco da posicao do mapa
		ret

MOV_DIR:	la t0, POS_MAPA		#endereco da posicao do mapa
		lh t1, 0(t0)		#valor do endereco
		addi t1, t1, 8		#
		li t2, 16		#t2 = 0
		beq t1, t2, GAME_LOOP	#se t1 == t2 é porque está na borda e o mapa não pode ir mais pra esquerda
		addi t1, t1, -8		
		addi t1, t1, 1		#caso contrário
		sh t1, 0(t0)		#salvando no endereco da posicao do mapa
		ret

EXIT:
		li a7, 10
		ecall
