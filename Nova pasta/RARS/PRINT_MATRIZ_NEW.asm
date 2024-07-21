.data
.include "TILES\black.s"
.include "TILES\gray.s"
.include "CHAR\red.s"
.include "CHAR\yellow.s"
.include "MAPA\background.s"
POS_MAPA: .half 0
.text
MAIN:
	jal PRINT_MATRIZ
	li a7, 10
	ecall
PRINT_MATRIZ:	
		la t0, background	#carrega o endereco do background
		lw t1,0(t0)		#carrega a largura
		addi t1, t1, 1		#t1 += 1
		lw t2, 4(t0)		#carrega a altura
		addi t0, t0, 8		#pula a largura e a altura
		li t4, 0		#t4 = 0
		li t5, 1		#t5 = 1
		mv a1, zero		#a1 = 0
		mv a2, zero		#a2 = 0
		
WHILE:		beq t4, t1, PULA_LINHA	#t4 = t1 ? caso sim pule para caso_1
		j ITERACOES		#caso não pule para iteracoes
PULA_LINHA:	
		beq t5, t2, END		#t5 = t2 ? caso sim pule para end
		addi t5, t5, 1		#t5 += 1
		li t4, 1		#t4 = 1
		addi a2, a2, 39		#a2 += 39
		j ITERACOES
				
ITERACOES:	
		lb t3, 0(t0)		#guarda os bytes de background em t3
		jal TYPE_TILE
		addi a1, a1, 40		#a1 += 40
		addi t0, t0, 1		#t0 += 1
		addi t4, t4, 1		#t4 += 1
		j WHILE
END:
		li a7, 10
		ecall

TYPE_TILE:
		li t6, 0		#t6 = 0		
		beq t6, t3, BLACK	#if t6 == t3
		li t6, 1		#t6 = 1
		beq t6, t3, GRAY	#if t6 == t3
		li t6, 2		#t6 = 2
		beq t6, t3, CHAR	#if t6 == t3

BLACK:		
		la a0, black
		j SALVAR
GRAY:
		la a0, gray
		j SALVAR
CHAR:
		beq a3, zero, RED
		j YELLOW
RED:
		la a0, red
		j SALVAR
YELLOW:
		la a0, yellow
		j SALVAR

SALVAR:		
		addi sp, sp, -28
		sw ra, 0(sp)
		sw t0, 4(sp)
		sw t1, 8(sp)
		sw t2, 12(sp)
		sw t3, 16(sp)
		sw t4, 20(sp)
		sw t5, 24(sp)
		jal PRINT
		lw ra, 0(sp)
		lw t0, 4(sp)
		lw t1, 8(sp)
		lw t2, 12(sp)
		lw t3, 16(sp)
		lw t4, 20(sp)
		lw t5, 24(sp)
		addi sp, sp, 28
		ret
PRINT:		
		li t0,0xFF0			# carrega 0xFF0 em t0
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
		
PRINT_LINHA:	
		lw t6,0(t1)			# carrega em t6 uma word (4 pixeis) da imagem
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
		ret				# retorna