.data

POS_MAPA: .half 0
CHAR_POS: .half 2, 1

.text
GAME_LOOP:
		call KEY2.1
		xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
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
.include "CHAR\red.s"
.include "CHAR\yellow.s"
#.include "FUNCOES\KEY_2.s"
.include "FUNCOES\KEY_2.1.s"
.include "FUNCOES\PRINT_MATRIZ_2.s"
	
