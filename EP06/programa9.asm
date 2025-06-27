# Programa 09

# Associações
# x1 -> $s0
# x2 -> $s1
# x3 -> $s2
# x4 -> $s3
# soma -> $s4

# Início

.text 

.globl main
main:
lui $t0, 0x1001		# temp0 = 0x10010000
lw  $s0, 0x00 ($t0)	# x1 = MEM[0x10010000]
lw  $s1, 0x04 ($t0)	# x2 = MEM[0x10010004]
lw  $s2, 0x08 ($t0)	# x3 = MEM[0x10010008]
lw  $s3, 0x0c ($t0)	# x4 = MEM[0x1001000c]
add $t1, $s0, $s1	# temp1 = x1 + x2
add $t1, $t1, $s2	# temp1 = temp1 + x3
add $s4, $t1, $s3	# soma  = temp1 + x4
sw  $s4, 0x10 ($t0)	# MEM[0x10010010] = soma

# Fim

.data 
x1: .word 15 
x2: .word 25 
x3: .word 13 
x4: .word 17 
soma: .word -1 
