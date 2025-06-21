# Programa 04
# x = 3;
# y = 4;
# z = (15*x + 67*y) * 4;

# Associações
# x -> $s0
# y -> $s1
# z -> $s2

# Início

.text
.globl main
main:
ori $s0, $zero, 0x3	# x = 3
ori $s1, $zero, 0x4	# y = 4
sll $t0, $s0,   4	# temp0 = 16x
sub $t0, $t0,   $s0	# temp0 = 15x
sll $t1, $s1,   6	# temp1 = 64y
add $t1, $t1,   $s1	# temp1 = 65y
add $t1, $t1,   $s1	# temp1 = 66y
add $t1, $t1,   $s1	# temp1 = 67y
add $t2, $t0,   $t1	# temp2 = temp0 + temp1
sll $s2, $t2,   2	# z = (temp0 + temp1) * 4;

# Fim
