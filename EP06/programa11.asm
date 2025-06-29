# Programa 11
# y = x – z + 300000

# Associações
# x -> $s0
# y -> $s1
# z -> $s2

# Início
.text 

.globl main
main:
lui $t0, 0x1001		# temp0 = 0x10010000
lw  $s0, 0x0 ($t0)	# x = MEM[0x10010000]
lw  $s2, 0x4 ($t0)	# z = MEM[0x10010004]
ori $t1, $zero, 0x493e	# temp1 = 0x493e
sll $t1, $t1, 4		# temp1 = 0x493e0 = 300000
sub $t2, $s0, $s2	# temp2 = x - z
add $s1, $t2, $t1	# y = temp2 + 300000 
sw  $s1, 0x8 ($t0)	# MEM[0x10010008] = y

# Fim

.data 
x: .word 100000 
z: .word 200000 
y: .word 0
