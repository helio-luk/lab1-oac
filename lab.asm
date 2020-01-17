.data
msg: .string "Digite a quantidade de pares de coordenadas (maior que 3) "
.text


#################################
##   Inicia capturando o       ##
##     numero do usuario       ##
#################################
novo:
la a0, msg
li a7, 4
ecall

li a7, 5
ecall
sltiu t0, a0, 3
bne t0, zero, novo
li a7, 1
ecall

mv s0, a0 #aqui é guardado o valor digitado pelo usuario
mv s1, sp #aqui é guardado a posicao da pilha
mv t4, s1       #variavel auxiliadora com a posição da pilha
#################################
##   Comeca a geracao do       ##
##     vetor de coordenadas    ##
#################################

add t1, zero, zero
VOLTA:
blt s0, t1, SAI

volta_gerador_x: # Aqui é onde é feita a geração dos numeros aleatorio
li a7, 41 #
ecall # Primeiramente se gera a coordenada x e em seguida a coordenada y
srli a0, a0, 19 #
add t3, zero, a0 #
sltiu t0, t3, 319 # O t3 é o X
beq t0, zero, volta_gerador_x #
#
volta_gerador_y: #
li a7, 41 #
ecall #
srli a0, a0, 20   #
add t2, zero, a0 #
sltiu t0, t2, 239 # O t2 é o Y
beq t0, zero, volta_gerador_y #
                                #
slli t3, t3, 16                 #
or t2, t2, t3                   # O t2 se transforma na coordenada em si


sw t2, 0(t4)
addi t4, t4, 4

addi t1, t1, 1
j VOLTA
SAI:
#################################
##   O vetor já foi gerado     ##
##     e guardado na memoria   ##
##       ##
##    Agora irá começar        ##
##    o desenho do poligono    ##
#################################



#add sp, sp, t0


#ret