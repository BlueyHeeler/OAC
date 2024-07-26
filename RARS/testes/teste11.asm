.include "MACROSv24.s"
.data
POS_MAPA: .half 0
CHAR_POS_UP: .half 3, 1
CHAR_POS_DOWN: .half 4, 1
ITEM_1_BYTE: .byte 0
PEQUENO_GRANDE: .byte 1
.text
GAME_LOOP:
	# ecall read time
	li a7,130
	ecall
	mv t0,a0
	mv t1,a1
	#ecall print int unsigned
	mv a0,t1
	li a7,136
	li a1,148
	li a2,56
	li a3,0x0038
	ecall
	#ecall print int unsigned
	mv a0,t0
	li a7,136
	li a1,236
	li a2,56
	li a3,0x0038
	ecall
		
		call KEY2.1
		xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
		mv a4, s0
		mv a3, s0
		la t0, POS_MAPA
		call PRINT_MATRIZ_2
		
		li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
		sw s0,0(t0)			# mostra o sprite pronto para o usuario
		
		j GAME_LOOP

.data
.include "MAPA\background2.s"
.include "TILES\black.s"
.include "TILES\gray.s"
.include "TILES\blue.s"
.include "CHAR\red.s"
.include "CHAR\yellow.s"
#.include "FUNCOES\KEY_2.s"
.include "FUNCOES\KEY_2.1.s"
.include "FUNCOES\PRINT_MATRIZ_2.s"

.include "SYSTEMv24.s"
