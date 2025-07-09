# Programa 20
# y = x^4 + x^3 - 2x^2	se x for par
#     x^5 – x^3 + 1	se x for impar

# Associações
# x -> $s0
# y -> $s1

# Início

.text

.globl main
main:
lui  $t0, 0x1001	# t0 = 0x10010000
lw   $s0, 0 ($t0)	# x = MEM[0x1001000]
andi $t1, $s0, 1	# Manter apenas o primeiro bit
beq  $t1, $zero, par	# Se o número for par, realizar o outro método
mult $s0, $s0		# x^2
mflo $t2,		# t2 = x^2
mult $t2, $t2		# x^4
mflo $t3		# t3 = x^4
mult $t3, $s0		# x^5
mflo $t3		# t3 = x^5
mult $t2, $s0		# x^3
mflo $t2		# t2 = x^3
sub  $t3, $t3, $t2	# t3 = t3 - t2
addi $s1, $t3, 1	# y = t3 + 1
j fim
par: 
mult $s0, $s0		# x^2
mflo $t2		# t2 = x^2
mult $t2, $s0		# x^3
mflo $t3		# t3 = x^3
mult $t2, $t2		# x^4
mflo $t4		# t4 = x^2
sll  $t2, $t2, 1	# t2 = 2*(x^2)
add  $t4, $t4, $t3	# t4 = t4 + t3
sub  $s1, $t4, $t2	# y = t4 - t2
j fim

fim:
sw   $s1, 4 ($t0)	# MEM [0x10010004] = y

# Fim

.data
x: .word  3
y: .word -1
