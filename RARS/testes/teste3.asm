.data
.include "script\Imagens\imagens_convertidas\arquivos\background.data"
.include "script\Imagens\imagens_convertidas\arquivos\black.data"
.include "script\Imagens\imagens_convertidas\arquivos\gray.data"
.include "script\Imagens\imagens_convertidas\arquivos\red.data"

.text
PERCORRE_MATRIZ:la t0, background	#carrega o endereco do background
		lw t1, 0(t0)		#carrega a largura
		addi t1, t1, 1
		lw t2, 4(t0)		#carrega a altura
		addi t0, t0, 8		#pula a largura e a altura
		li t4, 1		#t4 = 1
		li t5, 1		#t5 = 1
		mv s0, zero
		mv a1, zero		#a1 = 0
		mv a2, zero		#a2 = 0
		mv a3, zero		#a3 = 0
		
WHILE:		beq t4, t1, CASO_1	#t4 = t1 ? caso sim pule para caso_1
		j ITERACOES		#caso n�o pule para iteracoes

CASO_1:		beq t5, t2, END		#t5 = t2 ? caso sim pule para end
		addi t5, t5, 1		#t5 += 1
		li t4, 1		#t4 = 1
		addi a2, a2, 39		#a2 += 39
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
SALVAMENTO:		
		# Fun��o que salva os registradores na pilha
		addi sp, sp, -28      # Ajusta a pilha para armazenar 6 registradores
		sw t0, 0(sp)          # Salva t0 na pilha
		sw t1, 4(sp)          # Salva t1 na pilha
		sw t2, 8(sp)          # Salva t2 na pilha
		sw t3, 12(sp)         # Salva t3 na pilha
		sw t4, 16(sp)         # Salva t4 na pilha
		sw t5, 20(sp)         # Salva t5 na pilha
		sw ra, 24(sp)	      # Salva ra na pilha
		
		jal PRINT            # Chama a fun��o PRINT
		
		# Recupera os registradores da pilha
		lw t0, 0(sp)          # Carrega t0 da pilha
		lw t1, 4(sp)          # Carrega t1 da pilha
		lw t2, 8(sp)          # Carrega t2 da pilha
		lw t3, 12(sp)         # Carrega t3 da pilha
		lw t4, 16(sp)         # Carrega t4 da pilha
		lw t5, 20(sp)         # Carrega t5 da pilha
		lw ra, 24(sp)	      # Carrega ra da pilha
		addi sp, sp, 28       # Ajusta a pilha de volta
	
		ret                   # Retorna da fun��o


ret                   # Retorna da fun��o

END:
		j END
		li a7, 10
		ecall

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
		
		mv t0, zero
		mv t1, zero
		mv t2, zero
		mv t3, zero
		mv t4, zero
		mv t5, zero
		mv t6, zero
		ret				# retorna
