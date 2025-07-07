# Programa 18
# k = x^y

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
ori  $t2, $zero, 1		# t2 = 1

or   $a0, $s0, $zero
pow:
beq  $t1, $s1, fim		# Se t1==y, acabar loop
or   $a1, $t2, $zero
jal  mult
or   $t2, $v0, $zero
addi $t1, $t1, 1
j    pow			# Repetir loop


mult:
beq  $t3, $a0, fmult		# Se t1=a0, acabar loop
add  $t4, $t4, $a1		# t2 += a1
addi $t3, $t3, 1		# t1 += 1
j    mult			# Repetir loop
fmult:
or   $t3, $zero, $zero		# t3 = 0
or   $v0, $t4, $zero
or   $t4, $zero, $zero		# t4 = 0
jr   $ra

fim:
or   $s2, $t2, $zero		# k = t2
sw   $s2, 8 ($t0)		# MEM[0x1001008] = k

# Fim

.data
x: .word 5
y: .word 3
k: .word -1
