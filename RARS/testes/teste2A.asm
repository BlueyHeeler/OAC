.data
.include "MAPA\background.s"
espaco:
    	.asciz " "
pular:
	.asciz "\n"
.text
PRINT_MATRIZ:
	la t0, background	# Carrega o endereço do background
	lw t1, 0(t0)		# Carrega a largura
	lw t2, 4(t0)		# Carrega a altura
	addi t0, t0, 8		# Pula a largura e a altura no endereço do background
	
	li t4, 0		# Inicializa contador de colunas
	li t5, 1		# Inicializa contador de linhas

WHILE:	
	beq t4, t1, CASO_1	# Se t4 == t1, pule para CASO_1
	lb t3, 0(t0)		# Carrega um byte do background em t3
	add a0, t3, zero	# Move t3 para a0
	li a7, 1		# Código de syscall para impressão
	ecall
	
	la a0, espaco		# Carrega endereço de espaco
	li a7, 4		# Código de syscall para impressão de string
	ecall
	
	addi t0, t0, 1		# Incrementa o ponteiro do background
	addi t4, t4, 1		# Incrementa o contador de colunas
	j WHILE

CASO_1:	
	beq t5, t2, END		# Se t5 == t2, pule para END
	addi t5, t5, 1		# Incrementa o contador de linhas
	li t4, 0		# Reseta o contador de colunas para 1
	
	la a0, pular		# Carrega endereço de pular
	li a7, 4		# Código de syscall para impressão de string
	ecall
	
	j WHILE

END:
	li a7, 10		# Código de syscall para terminar o programa
	ecall