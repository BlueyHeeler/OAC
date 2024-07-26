.data
    TEMPO_INICIAL: .word 0   # Variável para armazenar o tempo inicial
    TEMPO_ATUAL: .word 0     # Variável para armazenar o tempo atual
    NUM: .half 45            # Número de notas a tocar
    # Lista de notas (tom, duração, tom, duração, ...)
    NOTAS: .half 60,156,72,156,60,156,72,156,71,156,60,156,71,156,67,937,64,312,62,156,60,156,72,156,60,156,72,156,71,
                   156,60,156,71,156,67,156,60,156,67,156,60,156,67,156,60,156,64,156,65,156,64,156,62,156,72,156,60,156,72,156,
                   71,156,60,156,71,156,67,937,64,312,62,156,60,156,64,156,62,156,60,156,64,156,62,156,60,156,67,625,62,937

.text
START:
    # Inicialização
    li a7, 30                # Carrega o número de ecall para ler o tempo
    ecall                    # Faz a chamada ao sistema
    mv s11, a0               # Armazena o tempo inicial em s11
    la t1, NOTAS             # Carrega o endereço da lista de notas em t1
    lh a0, 0(t1)             # Carrega a nota atual
    lh a1, 2(t1)             # Carrega a duração da nota em ms
    li a2, 7                 # Define o instrumento
    li a3, 127               # Define o volume
    li a7, 31                # Define a syscall para tocar a nota
    ecall                    # Toca a nota

MAIN:
    jal TEMPO                # Chama a função TEMPO
    j MAIN                   # Loop principal

TEMPO:
    # Leitura do tempo atual
    li a7, 30                # Carrega o número de ecall para ler o tempo
    ecall                    # Faz a chamada ao sistema

    sub a0, a0, s11          # Calcula deltaT (tempo decorrido)
    mv t0, a0                # Armazena deltaT em t0

    bge t0, a1, PROXIMA_NOTA # Se deltaT >= duração da nota, vai para PROXIMA_NOTA
    ret                      # Retorna para o chamador

PROXIMA_NOTA:
    lh a0, 0(t1)             # Carrega a nota atual
    lh a1, 2(t1)             # Carrega a duração da nota em ms
    li a2, 7                 # Define o instrumento
    li a3, 127               # Define o volume
    li a7, 31                # Define a syscall para tocar a nota
    ecall                    # Toca a nota
    addi t1, t1, 4           # Avança para a próxima nota (cada entrada é 2 bytes)
    li a7, 30                # Carrega o número de ecall para ler o tempo
    ecall                    # Faz a chamada ao sistema
    mv s11, a0               # Atualiza o tempo inicial em s11
    ret                      # Retorna para o chamador


