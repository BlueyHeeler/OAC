.include "MACROSv24.s"
.data
TEMPO_INICIAL: .word 0
TEMPO_ATUAL: .word 0
TEMPO_INI_VOANDO: .word 0
VOANDO: .byte 0
.text
START:
	    	# Inicialização
	    	li a7, 130        	# Carrega o número de ecall para ler o tempo
	    	ecall             	# Faz a chamada ao sistema
	    	la t0, TEMPO_INICIAL
	    	sw a0, 0(t0)

MAIN:
		jal TEMPO
		jal KEY2.1
		j MAIN
TEMPO:
	    	# Leitura do tempo atual
	    	li a7, 130        	# Carrega o número de ecall para ler o tempo
	    	ecall             	# Faz a chamada ao sistema	
	   	la t0, TEMPO_ATUAL	# Endereco do TEMPO_ATUAL
	   	sw a0, 0(t0)		# Salvando o tempo atual
	    	la t0, TEMPO_INICIAL	# Endereco do TEMPO_INICIAL
	    	lw t0, 0(t0)		# Carregando em t0 o TEMPO_INICIAL
	    	sub a0, a0, t0		# Calculando o tempo atual
	    	li t3, 100		# t3 = 100
	    	div a0, a0, t3 		# Deixando apenas o decisegundo
	    	li a7,136
		li a1,236
		li a2,56
		li a3,0x0038
		li a4,0
		ecall			# Chamada de sistema
		la t0, VOANDO		# Endereco do VOANDO
		lb t0, 0(t0)		# Carregando do Endereco
		beq t0, zero, END_TEMPO	# Se t0 == 0, ou seja, não estiver voando KEY2.1
		la t0, TEMPO_INI_VOANDO
		lw t0, 0(t0)
		la t1, TEMPO_ATUAL
		lw t1, 0(t1)
		sub a0, t1, t0
		li t3, 2000
		bge a0, t3, END_TEMPO
		li t3, 100
		div a0, a0, t3
		li a7,136
		li a1,286
		li a2,56
		li a3,0x0038
		li a4,0
		ecall
		ret
		
END_TEMPO:	
		ret
FLOOR:
		la t0, VOANDO	
		sb zero, 0(t0)
		li a0, 0
		li a7,136
		li a1,286
		li a2,56
		li a3,0x0038
		li a4,0
		ecall
		ret
	
	
    
KEY2.1:		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,DEFAULT   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
		
		li t0,'W'
		beq t2, t0, W
W:
		la t0, VOANDO
		li t1, 1
		sb t1, 0(t0)
		li a7, 130
		ecall
		la t0, TEMPO_INI_VOANDO
		sw a0, 0(t0)
DEFAULT:
		ret
.include "SYSTEMv24.s"
