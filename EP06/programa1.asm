# Programa 01
# a = 2;
# b = 3;
# c = 4;
# d = 5;
# x = (a+b) - (c+d);
# y = a - b + x;
# b = x - y;

# Associações
# a -> $s0
# b -> $s1
# c -> $s2
# d -> $s3
# x -> $s4
# y -> $s5

# Início

.text
.globl main
main:
ori $s0, $zero, 0x2	# a = 2
ori $s1, $zero, 0x3	# b = 3
ori $s2, $zero, 0x4	# c = 4
ori $s3, $zero, 0x5	# d = 5
add $t0, $s0,   $s1	# temp1 = a+b
add $t1, $s2,   $s3	# temp2 = c+d
sub $s4, $t0,   $t1	# x = temp1 - temp2
sub $t0, $s0,   $s1	# temp1 = a - b
add $s5, $t0,   $s4	# y = temp1 + x
sub $s1, $s4,   $s5	# b = x - y

# Fim