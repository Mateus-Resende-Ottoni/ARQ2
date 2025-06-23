# Programa 06
# x = maior inteiro possível; (0x7fffffff)
# y = 300000;
# z = x - 4y;

# Associações
# x -> $s0
# y -> $s1
# z -> $s2

# Início

.text
.globl main
main:

ori $t0, $zero, 0x7fff	# temp0 = 0x7fff
sll $t0, $t0,   16	# temp0 = 0x7fff0000
ori $s0, $t0,   0xffff	# x     = 0x7fffffff
ori $t0, $zero, 0x493e	# temp0 = 0x493e
sll $s1, $t0,   4	# y     = 0x493e0 = 300000
sll $t0, $s1,   2	# temp0 = 4y
sub $s2, $s0,   $t0	# z     = x - 4y

# Fim
