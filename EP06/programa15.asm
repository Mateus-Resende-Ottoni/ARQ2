# Programa 15
# Vetor de 100 elementos
# vetor[i] = 2*i + 1
# Soma dos elementos do vetor

# Associações
# soma -> $s0

# Início

.text

.globl main
main:
lui  $t0, 0x1001		# t0 = 0x10010000
or   $t1, $zero, $zero		# t1 = 0
ori  $t2, $zero, 100		# t2 = 100
vetor:
beq  $t1, $t2, fvetor		# se t1 igual a 100, acabar loop
sll  $t3, $t1, 1		# t3 = t1 * 2
addi $t3, $t3, 1		# t3 = t3 + 1 = t1*2 + 1
sw   $t3, 0 ($t0)		# MEM[t0] = t3
addi $t1, $t1, 1		# t1 += 1
addi $t0, $t0, 4		# t0 += 4
j   vetor
fvetor:
or   $t0, $zero, $zero		# t0 = 0x0
lui  $t0, 0x1001		# t0 = 0x10010000
or   $t1, $zero, $zero		# t1 = 0
or   $t4, $zero, $zero		# t4 = 0
soma:
beq  $t1, $t2, fim		# se t1 igual a 100, acabar loop
lw   $t3, 0 ($t0)		# t3 = MEM[t0]
add  $t4, $t4, $t3		# t4 += t3
addi $t1, $t1, 1		# t1 += 1
addi $t0, $t0, 4		# t0 += 4
j soma
fim:
or   $s0, $zero, $t4		# soma = t4
sw   $s0, 0 ($t0)		# MEM[t0] = soma

# Fim