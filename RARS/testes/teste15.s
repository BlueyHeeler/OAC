.include "MACROSv24.s"
.data
TEMPO_INICIAL: .word
TEMPO_ATUAL: .word


.text
START:
	    	# Inicialização
	    	li a7, 30        	# Carrega o número de ecall para ler o tempo
	    	ecall             	# Faz a chamada ao sistema
	    	mv s11, a0

MAIN:
		jal TEMPO
		j MAIN
TEMPO:
	    	# Leitura do tempo atual
	    	li a7, 30        	# Carrega o número de ecall para ler o tempo
	    	ecall             	# Faz a chamada ao sistema	
	    	la t0, TEMPO_ATUAL
	    	sw a0, 0(t0)
	    	sub a0, a0, s11
		li t0, 1000
		bge a0, t0, ZERA_TEMPO_INI
		ret

ZERA_TEMPO_INI:
		li a0,40		# define a nota
		li a1,1500		# define a duração da nota em ms
		li a2,127		# define o instrumento
		li a3,127		# define o volume
		li a7,31		# define o syscall
		ecall			# toca a nota
		li a7, 30
		ecall
		mv s11, a0
		ret
		
.include "SYSTEMv24.s"
