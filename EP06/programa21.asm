# Programa 21
# y = x^3 + 1	se x > 0
#     x^4 – 1	se x <= 0

# Associações
# x -> $s0
# y -> $s1

# Início

.text

.globl main
main:
lui  $t0, 0x1001	# t0 = 0x10010000
lw   $s0, 0 ($t0)	# x  = MEM[0x1001000]
slt  $t1, $zero, $s0	
bne  $t1, $zero, maior	# Se o número for maior que zero,
			#  realizar o outro método


mult $s0, $s0		# x^2
mflo $t2		# t2  = x^2
mult $t2, $t2		# x^4
mflo $t2		# t2  = x^4
addi $s1, $t2, -1	# y   = t2 - 1
j fim
maior: 
mult $s0, $s0		# x^2
mflo $t2,		# t2  = x^2
mult $t2, $s0		# x^3
mflo $t2		# t2  = x^3
addi $s1, $t2, 1	# y   = t2 + 1
j fim

fim:
sw   $s1, 4 ($t0)	# MEM [0x10010004] = y
addi $v0, $zero, 10
syscall

# Fim

.data
x: .word  0
y: .word -1
