# Programa 02
# x = 1;
# y = 5*x + 15;

# Associações
# x -> $s0
# y -> $s1

# Início

.text
.globl main
main:
ori  $s0, $zero, 0x1	# x = 1
add  $t0, $s0,   $s0	# temp0 = 2x
add  $t0, $t0,   $t0	# temp0 = 4x
add  $t0, $t0,   $s0	# temp0 = 5x
addi $s1, $t0,   0xf	# y = temp0 + 15

# Fim
