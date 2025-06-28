# Programa 10
# y = 127x – 65z + 1

# Associações
# x -> $s0
# y -> $s1
# z -> $s2

# Início

.text 

.globl main
main:
lui  $t0, 0x1001		# temp0 = 0x10010000
lw   $s0, 0x0 ($t0)	# x = MEM[0x10010000]
lw   $s2, 0x4 ($t0)	# z = MEM[0x10010004]
sll  $t1, $s0, 7	# temp1 = 128 * x
sub  $t1, $t1, $s0	# temp1 = 127 * x
sll  $t2, $s2, 6	# temp2 = 64 * z
add  $t2, $t2, $s2	# temp2 = 65 * z
sub  $t3, $t1, $t2	# temp3 = temp1 - temp2 = 127x - 65z
addi $s1, $t3, 0x1	# y = temp3 + 1 = 127x - 65z + 1
sw   $s1, 0x8 ($t0)	# MEM[0x10010008] = y

# Fim

.data 
x: .word 5 
z: .word 7 
y: .word 0 
