.data
.space 24
CHAR_POS:	.half 1,2			# x, y
OLD_CHAR_POS:	.half 1,2			# x, y
.include "script\Imagens\imagens_convertidas\arquivos .data\background.data"
.include "script\Imagens\imagens_convertidas\arquivos .data\black.data"
.include "script\Imagens\imagens_convertidas\arquivos .data\gray.data"
.include "script\Imagens\imagens_convertidas\arquivos .data\red.data"

.text
		mv s0, zero
GAME_LOOP:	call KEY2		# chama o procedimento de entrada do teclado
		
		xori s0,s0,1		# inverte o valor frame atual (somente o registrador)
		
		j PRINT_MATRIZ

		
PRINT_MATRIZ:	la t0, background	#carrega o endereco do background
		lw t1, 0(t0)		#carrega a largura
		addi t1, t1, 1
		lw t2, 4(t0)		#carrega a altura
		addi t0, t0, 8		#pula a largura e a altura
		li t4, 1		#t4 = 1
		li t5, 1		#t5 = 1
		mv a1, zero		#a1 = 0
		mv a2, zero		#a2 = 0
		mv a3, zero		#a3 = 0
		
WHILE:		beq t4, t1, CASO_1	#t4 = t1 ? caso sim pule para caso_1
		j ITERACOES		#caso n�o pule para iteracoes

CASO_1:		beq t5, t2, END		#t5 = t2 ? caso sim pule para end
		addi t5, t5, 1		#t5 += 1
		li t4, 1		#t4 = 1
		addi a2, a2, 40		#a2 += 40
		j ITERACOES
				
ITERACOES:	lb t3, 0(t0)		#guarda os bytes de background em t3
		li t6, 0		#t6 = 0
		bne t3, t6, CASE2	#se t6 != t3
		la a0, black		#carrega em a0 o endereco de black
		jal SALVAMENTO
		addi a1, a1, 40		#a1 += 40	
		addi t0, t0, 1		#t0 += 1
		addi t4, t4, 1		#t4 += 1
		addi s0, s0 ,1
		j WHILE
		
CASE2:		li t6, 1
		bne t3, t6, CASE3	#se t6 != t3
		la a0, gray
		jal SALVAMENTO
		addi a1, a1, 40		#a1 += 40	
		addi t0, t0, 1		#t0 += 1
		addi t4, t4, 1		#t4 += 1
		addi s0, s0 ,1
		j WHILE

CASE3:		la a0, red
		jal SALVAMENTO
		addi a1, a1, 40		#a1 += 40	
		addi t0, t0, 1		#t0 += 1
		addi t4, t4, 1		#t4 += 1
		addi s0, s0 ,1
		j WHILE
		
SALVAMENTO:	#FUNCAO QUE SALVA NA MEM�RIA 
		li sp, 0x10010000
		sw t0, 0(sp)
		sw t1, 4(sp)
		sw t2, 8(sp)
		sw t3, 12(sp)
		sw t4, 16(sp)
		sw t5, 20(sp)
		sw ra, 24(sp)
		call PRINT
		li sp, 0x10010000
		lw ra, 24(sp)
		lw t5, 20(sp)
		lw t4, 16(sp)
		lw t3, 12(sp)
		lw t2, 8(sp)
		lw t1, 4(sp)
		lw t0, 0(sp)
		ret
END:
		j GAME_LOOP

#################################################
#	a0 = endere�o imagem			#
#	a1 = x					#
#	a2 = y					#
#	a3 = frame (0 ou 1)			#
#################################################
#	t0 = endereco do bitmap display		#
#	t1 = endereco da imagem			#
#	t2 = contador de linha			#
# 	t3 = contador de coluna			#
#	t4 = largura				#
#	t5 = altura				#
#################################################

PRINT:		li t0,0xFF0			# carrega 0xFF0 em t0
		add t0,t0,a3			# adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
		slli t0,t0,20			# shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
		
		add t0,t0,a1			# adiciona x ao t0
		
		li t1,320			# t1 = 320
		mul t1,t1,a2			# t1 = 320 * y
		add t0,t0,t1			# adiciona t1 ao t0
		
		addi t1,a0,8			# t1 = a0 + 8
		
		mv t2,zero			# zera t2
		mv t3,zero			# zera t3
		
		lw t4,0(a0)			# carrega a largura em t4
		lw t5,4(a0)			# carrega a altura em t5
		
PRINT_LINHA:	lw t6,0(t1)			# carrega em t6 uma word (4 pixeis) da imagem
		sw t6,0(t0)			# imprime no bitmap a word (4 pixeis) da imagem
		
		addi t0,t0,4			# incrementa endereco do bitmap
		addi t1,t1,4			# incrementa endereco da imagem
		
		addi t3,t3,4			# incrementa contador de coluna
		blt t3,t4,PRINT_LINHA		# se contador da coluna < largura, continue imprimindo

		addi t0,t0,320			# t0 += 320
		sub t0,t0,t4			# t0 -= largura da imagem
		# ^ isso serve pra "pular" de linha no bitmap display
		
		mv t3,zero			# zera t3 (contador de coluna)
		addi t2,t2,1			# incrementa contador de linha
		bgt t5,t2,PRINT_LINHA		# se altura > contador de linha, continue imprimindo
		
		ret				# retorna

KEY2:		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'w'
		beq t2,t0,CHAR_CIMA		# se tecla pressionada for 'w', chama CHAR_CIMA
		
		li t0,'a'
		beq t2,t0,CHAR_ESQ		# se tecla pressionada for 'a', chama CHAR_CIMA
		
		li t0,'s'
		beq t2,t0,CHAR_BAIXO		# se tecla pressionada for 's', chama CHAR_CIMA
		
		li t0,'d'
		beq t2,t0,CHAR_DIR		# se tecla pressionada for 'd', chama CHAR_CIMA
	
FIM:		ret				# retorna

CHAR_CIMA:	la t0, background
		la t1, CHAR_POS
		la t2, OLD_CHAR_POS
		
		ret
		
CHAR_ESQ:	
		ret
		
CHAR_BAIXO:	
		ret

CHAR_DIR:	
		ret
