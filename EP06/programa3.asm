# Programa 03
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
add $t0, $s0,   $s0	# temp0 = 2x
add $t0, $t0,   $t0	# temp0 = 4x
add $t0, $t0,   $t0	# temp0 = 8x
add $t0, $t0,   $t0	# temp0 = 16x
sub $t0, $t0,   $s0	# temp0 = 15x
add $t1, $s1,   $s1	# temp1 = 2y
add $t1, $t1,   $t1	# temp1 = 4y
add $t1, $t1,   $t1	# temp1 = 8y
add $t1, $t1,   $t1	# temp1 = 16y
add $t1, $t1,   $s1	# temp1 = 17y
add $t1, $t1,   $t1	# temp1 = 34y
add $t1, $t1,   $t1	# temp1 = 68y
sub $t1, $t1,   $s1	# temp1 = 67y
add $t2, $t0,   $t1	# temp2 = temp0 + temp1
add $t2, $t2,   $t2	# temp2 = (temp0 + temp1) * 2
add $s2, $t2,   $t2	# z = (temp0 + temp1) * 4;

# Fim
