# ====================
# Projeto Redes Neurais - Arquitetura de Computadores
# Alunos: Erika Marcia e Italo Lelis
# Professor: Luis Fabricio W. Goes
# ====================

# O perceptron tem como objetivo receber a nota (0-10) das duas provas aplicadas
# durante o semestre (uma com peso 60 e a outra com peso 40) e retornar 0 se
# o aluno foi reprovado e 1 se o aluno foi aprovado.
# Alem disso, caso tenha sido aplicada alguma pontuacao extra, essa sera
# acresentada no vies do perceptron.

# Para isso, o perceptron recebera duas entradas e retornara a soma dessas
# entradas, considerando-se os pesos. Apos isso, a função de ativação analisa
# se o valor é maior do que 60.

# Para efeito de demonstracao, os pesos e o vies do perceptron
# ja estao sendo definidos. Considera-se que esses foram obtidos a partir de
# um treinamento previo.

.data

    nova_linha: .asciiz "\n"

    mensagem_peso1: .asciiz "Peso 1: "
    mensagem_peso2: .asciiz "\nPeso 2: "

    mensagem_taxa: .asciiz "Digite a taxa de aprendizado: "
    mensagem_primeiro: .asciiz "\n\nDigite o primeiro numero: "
    mensagem_segundo: .asciiz "Digite o segundo numero: "

    mensagem_resultado: .asciiz "\nSaida do perceptron: "
    mensagem_aprovado: .asciiz "\nO aluno foi aprovado! :)"
    mensagem_reprovado: .asciiz "\nO aluno foi reprovado! :("

    taxa_aprendizado: .float 0.0

    entrada_teste_1: .word 1, 2, 3, 4, 5 
    saida_desejada_1: .word 6, 12, 18, 24, 30

    entrada_teste_2: .word 1, 2, 3, 4, 5
    saida_desejada_2: .word 4, 8, 12, 16, 20

    soma: .word 0
    peso1: .float 1.4
    peso2: .float 1.2
    vies: .word 0

    valor1: .word 1
    valor2: .word 1

    saida: .word 0


.text

## 0. Taxa de aprendizado
 
        # Imprimir mensagem
        # Cod 4 = Imprimir string no console
main:   li $v0, 4
        la $a0, mensagem_taxa
        syscall

        # Pegar taxa de aprendizagem
        # Cod 6 = Leitura de um float no console
        li $v0, 6
        syscall
        swc1 $f0, taxa_aprendizado # Salvar float na memoria utilizando o coprocessador 1

# 0.1 Treinamento do Peso 1

add $t1, $zero, $zero # i - for epocas

for_epocas1: add $t2, $zero, $zero # j - for array
            

            # Carregar entrada esperada do vetor
for_array1:  la $s1, entrada_teste_1
            move $t4, $t2
            add $t4, $t4, $t4
            add $t4, $t4, $t4
            add $t5, $t4, $s1
            lw $t0, 0($t5)              # Carregar int e converter para float
            mtc1 $t0, $f4
            cvt.s.w $f4, $f4            # $f4 - Entrada de Teste

            # Carregar saida esperada do vetor
            la $s3, saida_desejada_1
            move $t4, $t2
            add $t4, $t4, $t4
            add $t4, $t4, $t4
            add $t5, $t4, $s3
            lw $t0, 0($t5)              # Carregar int e converter para float
            mtc1 $t0, $f6
            cvt.s.w $f6, $f6            # $f6 - Saida Esperada

            # Calculo do erro
            lwc1 $f2, peso1             # $f2 - Peso
            lwc1 $f3, taxa_aprendizado  # $f3 - Taxa de Aprendizado

            mul.s $f8, $f2, $f4         # $f8 - x*w
            sub.s $f10, $f6, $f8        # $f10 - Erro

            mul.s $f12, $f10, $f3
            mul.s $f12, $f12, $f4
            add.s $f12, $f12, $f2       # $f12 - Novo Peso

            swc1 $f12, peso1 # Salvar float na memoria utilizando o coprocessador 1

            # Analisar repeticao do for_array1
            li $t0, 5
            addi $t2, $t2, 1
            blt $t2, $t0, for_array1

            # Analisar repeticao do for_epocas1
            li $t0, 5
            addi $t1, $t1, 1
            blt $t1, $t0, for_epocas1

            li $v0, 4
            la $a0, mensagem_peso1
            syscall

            li $v0, 2
            mov.s $f12, $f12
            syscall


# 0.1 Treinamento do Peso 2

add $t1, $zero, $zero # i - for epocas

for_epocas2: add $t2, $zero, $zero # j - for array
            

            # Carregar entrada esperada do vetor
for_array2:  la $s1, entrada_teste_2
            move $t4, $t2
            add $t4, $t4, $t4
            add $t4, $t4, $t4
            add $t5, $t4, $s1
            lw $t0, 0($t5)              # Carregar int e converter para float
            mtc1 $t0, $f4
            cvt.s.w $f4, $f4            # $f4 - Entrada de Teste

            # Carregar saida esperada do vetor
            la $s3, saida_desejada_2
            move $t4, $t2
            add $t4, $t4, $t4
            add $t4, $t4, $t4
            add $t5, $t4, $s3
            lw $t0, 0($t5)              # Carregar int e converter para float
            mtc1 $t0, $f6
            cvt.s.w $f6, $f6            # $f6 - Saida Esperada

            # Calculo do erro
            lwc1 $f2, peso2             # $f2 - Peso
            lwc1 $f3, taxa_aprendizado  # $f3 - Taxa de Aprendizado

            mul.s $f8, $f2, $f4         # $f8 - x*w
            sub.s $f10, $f6, $f8        # $f10 - Erro

            mul.s $f12, $f10, $f3
            mul.s $f12, $f12, $f4
            add.s $f12, $f12, $f2       # $f12 - Novo Peso

            swc1 $f12, peso2 # Salvar float na memoria utilizando o coprocessador 1

            # Analisar repeticao do for_array2
            li $t0, 5
            addi $t2, $t2, 1
            blt $t2, $t0, for_array2

            # Analisar repeticao do for_epocas2
            li $t0, 5
            addi $t1, $t1, 1
            blt $t1, $t0, for_epocas2

            li $v0, 4
            la $a0, mensagem_peso2
            syscall

            li $v0, 2
            mov.s $f12, $f12
            syscall


## 1. Pegar valores das entradas

        # Imprimir primeira mensagem
        li $v0, 4
        la $a0, mensagem_primeiro
        syscall

        # Pegar valor x1 no input
        li $v0, 5
        syscall
        sw $v0, valor1


        # Imprimir segunda mensagem
        li $v0, 4
        la $a0, mensagem_segundo
        syscall

        # Pegar valor x2 no input
        li $v0, 5 
        syscall
        sw $v0, valor2


## 2. Calcular resultado das entradas (x + w) e fazer a soma (x1*w1 + x2*w2 + ... + xn+wn)

        # Calculo da entrada 1
        lw $t0, soma        # Carrega a soma da memoria
        lw $t1, valor1      # Carrega a entrada 1 da memoria
        lwc1 $f2, peso1     # Carrega o peso 1 da memoria
        cvt.w.s $f1, $f2    # Converter de float para int
        mfc1 $t2, $f1       # Salvar num registrador de int

        li $v0, 1
        move $a0, $t2
        syscall

        mul $t3, $t1, $t2   # Multiplica x1*w1
        add $t0, $t0, $t3   # Adiciona o resultado na soma

        sw $t0, soma


        # Calculo da entrada 2
        lw $t0, soma        # Carrega a soma da memoria
        lw $t1, valor2      # Carrega a entrada 2 da memoria
        lwc1 $f2, peso2     # Carrega o peso 2 da memoria
        cvt.w.s $f1, $f2
        mfc1 $t2, $f1

        mul $t3, $t1, $t2   # Multiplica x2*w2
        add $t0, $t0, $t3   # Adiciona o resultado na soma

        sw $t0, soma        # Salva a soma na memoria


## 3. Adicionar valor do vies (sum(xn*wn) + b)

        lw $t0, soma        # Carrega a soma da memoria
        lw $t1, vies        # Carrega o vies (bias)
        add $t0, $t0, $t1   # Adiciona o resultado na soma


## 4. Passar somatorio total pela funcao de ativacao

        li $t0, 59
        lw $t1, soma
        slt $t2, $t0, $t1

        sw $t2, saida


## 5. Retornar valor final do neuronio

        # Imprimir saida do neuronio
        li $v0, 4
        la $a0, mensagem_resultado
        syscall

        li $v0, 1
        move $a0, $t2
        syscall


        # Imprimir mensagem do significado da saida

        beq $t2, $0, else

        li $v0, 4
        la $a0, mensagem_aprovado
        syscall

        j endif

else:   li $v0, 4
        la $a0, mensagem_reprovado
        syscall


# Finalizar programa
endif:  jr $ra
