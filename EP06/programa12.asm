# Programa 12
# k = MEM [ MEM [MEM [ x ] ] ]
# k = 2 * k

# Associações
# k -> $s0

# Início
.text 

.globl main
main:
lui $t0, 0x1001		# temp0 = 0x10010000
lw  $t1, 0x0 ($t0)	# temp1 = MEM[0x10010000]
lw  $t2, 0x0 ($t1)	# temp2 = MEM[0x10010004]
lw  $t1, 0x0 ($t2)	# temp1 = MEM[0x10010008]
lw  $s0, 0x0 ($t1)	# k = MEM[0x10010008]
sll $s0, $s0, 1
sw  $s0, 0x0 ($t1)

# Fim

.data 
x:  .word 0x10010004
x1: .word 0x10010008  
x2: .word 0x1001000c
x3: .word 8
