.data
RA_print_matriz: .word 0
.text
PRINT_MATRIZ_2:	
		la t0, RA_print_matriz
		sw ra, 0(t0)
		la t0, POS_MAPA			#posicao do mapa
		lh t1, 0(t0)			#valor da posicao do mapa
		la s1, background2		#carrega o endereco do background
		li s2, 8			#(QUANTIDADE DE BLOCOS NA HORIZONTAL QUE SERÃO RENDERIZADOS)
		addi s2, s2, 1
		lw s3, 4(s1)			#(QUANTIDADE DE BLOCOS NA VERTICAL QUE SERÃO RENDERIZADOS)
		addi s1, s1, 8			#pula a largura e a altura
		add s1, s1, t1			#NOVA POSICAO DO MAPA
		li s5, 1			#s5 = 1
		li s6, 1			#s6 = 1
		mv a1, zero			#a1 = 0
		mv a2, zero			#a2 = 0
		jal PULAR_COLUNA
		
PULAR_COLUNA:	beq s5, s2, PULAR_LINHA 	#s5 = s2 ? caso sim pule para caso_1
		jal CASE1				#caso não pule para iteracoes

PULAR_LINHA:	addi s1, s1, 8			#PULA OS BLOCOS QUE NÃO DEVEM SER IMPRESSOS, OU SEJA, PULA A LINHA
		beq s6, s3, END			#s6 = s3 ? caso sim pule para end
		addi s6, s6, 1			#s6 += 1
		li s5, 1			#s5 = 1
		addi a2, a2, 39			#a2 += 39
		j CASE1
				
CASE1:		lb s4, 0(s1)			#guarda os bytes de background em s4
		li s7, 0			#s7 = 0
		bne s4, s7, CASE2		#se s7 != s4
		la a0, black			#carrega em a0 o endereco de black
		jal PRINT
		addi a1, a1, 40			#a1 += 40	
		addi s1, s1, 1			#s1 += 1
		addi s5, s5, 1			#s5 += 1
		j PULAR_COLUNA	
		
CASE2:		li s7, 1
		bne s4, s7, CASE3		#se s7 != s4
		la a0, gray
		jal PRINT
		addi a1, a1, 40			#a1 += 40	
		addi s1, s1, 1			#s1 += 1
		addi s5, s5, 1			#s5 += 1
		j PULAR_COLUNA

CASE3:		
		li s7, 1
		beq a3, s7, CASE3_2
		la a0, red
		jal PRINT
		addi a1, a1, 40			#a1 += 40	
		addi s1, s1, 1			#s1 += 1
		addi s5, s5, 1			#s5 += 1
		j PULAR_COLUNA
CASE3_2:
		la a0, yellow
		jal PRINT
		addi a1, a1, 40
		addi s1, s1, 1
		addi s5, s5, 1
		j PULAR_COLUNA

END:
		la t0, RA_print_matriz
		lw ra, 0(t0)
		ret
.include "PRINT.s"
