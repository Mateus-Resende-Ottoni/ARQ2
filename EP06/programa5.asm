# Programa 05
# x = 100000;
# y = 200000;
# z = x = y;

# Assosiações
# x -> $s0
# y -> $s1
# z -> $s2

# Início

.text
.globl main
main:
ori $t0, $zero, 0x186a		# temp0 = 0x186a
sll $s0, $t0,   4		# temp0 = 0x186a0
ori $t0, $zero, 0x30d4		# temp0 = 0x30d4
sll $s1, $t0,   4		# y = 0x30d40
add $s2, $s0,   $s1		# z = x + y

# Fim