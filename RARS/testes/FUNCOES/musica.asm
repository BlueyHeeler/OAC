###############################################
#  Programa de exemplo para Syscall MIDI      #
#  ISC Abr 2018				      #
#  Marcus Vinicius Lamar		      #
###############################################

.data
# Numero de Notas a tocar
NUM: .half 45
# lista de nota,duração,nota,duração,nota,duração,...
NOTAS: .half 60,156,72,156,60,156,72,156,71,156,60,156,71,156,67,937,64,312,62,156,60,156,72,156,60,156,72,156,71,
156,60,156,71,156,67,156,60,156,67,156,60,156,67,156,60,156,64,156,65,156,64,156,62,156,72,156,60,156,72,156,
71,156,60,156,71,156,67,937,64,312,62,156,60,156,64,156,62,156,60,156,64,156,62,156,60,156,67,625,62,937,

.text
	la s0,NUM		# define o endereço do número de notas
	lh s1,0(s0)		# le o numero de notas
	la s0,NOTAS		# define o endereço das notas
	li t0,0			# zera o contador de notas
	li a2,7			# define o instrumento
	li a3,127		# define o volume

LOOP:	beq t0,s1, FIM		# contador chegou no final? então  vá para FIM
	lh a0,0(s0)		# le o valor da nota
	lh a1,2(s0)		# le a duracao da nota
	li a7,33		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a duração da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	addi s0,s0,4		# incrementa para o endereço da próxima nota
	addi t0,t0,1		# incrementa o contador de notas
	j LOOP			# volta ao loop
	
FIM:	
	li a7,10		# define o syscall Exit
	ecall			# exit

