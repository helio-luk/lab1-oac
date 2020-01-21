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

mv s0, a0 			#aqui é guardado o valor digitado pelo usuario
mv s1, sp 			#aqui é guardado a posicao da pilha
mv t4, s1       		#variavel auxiliadora com a posição da pilha
#################################
##   Comeca a geracao do       ##
##     vetor de coordenadas    ##
#################################

add t1, zero, zero
VOLTA:
blt s0, t1, SAI

volta_gerador_x: 		# Aqui é onde é feita a geração dos numeros aleatorio
li a7, 41 			#
ecall 				# Primeiramente se gera a coordenada x e em seguida a coordenada y
srli a0, a0, 19			#
add t3, zero, a0 		#
sltiu t0, t3, 319 		# O t3 é o X
beq t0, zero, volta_gerador_x 	#
				#
volta_gerador_y: 		#
li a7, 41 			#
ecall 				#
srli a0, a0, 20   		#
add t2, zero, a0 		#
sltiu t0, t2, 239 		# O t2 é o Y
beq t0, zero, volta_gerador_y 	#
                                #
slli t3, t3, 16                 #
or t2, t2, t3                   # O t2 se transforma na coordenada em si


sw t2, 0(t4)
addi t4, t4, -4

addi t1, t1, 1
j VOLTA
SAI:
#################################
##   O vetor já foi gerado     ##
##     e guardado na memoria   ##
##             ##
##    Agora irá começar        ##
##    o desenho do poligono    ##
#################################

addi t0, t0, 1 #flag do bubblesort
addi t1, zero, 0        #variavel de controle do for i
addi t5, s0, 0 #variavel auxiliar do for
WHILE: beq t0, zero, FIM_WHILE
addi t0, t0, -1
FOR:   ble t5, t1, FIM_FOR

mv t2, s1 # Neste ponto é calculado os indices do vetor
addi t6, zero, -4 #
mul t6, t6, t1 #
add t2, t2, t6 # aqui e colocado o indice da primeira posição
addi t3, t2, -4 # Aqui é colococado o indice da segunda posição

lw s10, 0(t2)
lw s11, 0(t3)

lw s8, 0(t2)
lw s9, 0(t3)

slli s8, s8, 16
slli s9, s9, 16

srli s8, s8, 16
srli s9, s9, 16

srli s10, s10, 16
srli s11, s11, 16

ble s10, s11, FIM_IF
addi t0, t0, 1
mv t4, s10
mv s10, s11
mv s11, t4

slli s10, s10, 16
slli s11, s11, 16

or s10, s10, s9
or s11, s11, s8

sw s10, 0(t2)
sw s11, 0(t3)
FIM_IF:
addi t1, t1, 1
j FOR
FIM_FOR:
addi t1, zero, 0
j WHILE
FIM_WHILE:


#################################
##   Neste Ponto o vetor está  ##
##   ordenado e a primeira     ##
##    e a ultima posicao       ##
##    são os pontos Xmin e Xmax##
##    Agora a reta meio será   ##
##          desenhada       ##
#################################

addi t0, zero, 4
mul t0, t0, s0

mv t4, s1

lw t1, 0(s1)
add t4, t4, t0
lw t2, 0(t4)

srli t4, t1, 16
srli t5, t2, 16

sub t1, t5, t4 # t1 = x - x0

andi t4, t1, 0x0F
andi t5, t2, 0x0F

sub t2, t5, t4 #t2 = y - y0


fcvt.s.w ft0, t1
fcvt.s.w ft1, t2
fdiv.s   ft2, ft1, ft0 #ft2 = coeficiente angular da reta