# Programa 17
# k = x * y (Através de somas)

# Associações
# x -> $s0
# y -> $s1
# k -> $s2

# Início

.text

.globl main
main:
lui  $t0, 0x1001		# t0 = 0x10010000
lw   $s0, 0 ($t0)		# x = MEM[0x1001000]
lw   $s1, 4 ($t0)		# y = MEM[0x1001004]
or   $t1, $zero, $zero		# t1 = 0
or   $t2, $zero, $zero		# t2 = 0
mult:
beq  $t1, $s1, fim		# Se t1==y, acabar loop
add  $t2, $t2, $s0		# t2 += x
addi $t1, $t1, 1		# t1 += 1
j    mult			# Repetir loop
fim:
or   $s2, $t2, $zero		# k = t2
sw   $s2, 8 ($t0)		# MEM[0x1001008] = k

# Fim

.data
x: .word 15
y: .word 3
k: .word -1
