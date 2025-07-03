# Programa 14

# Associações
# a -> $s0
# b -> $s1

# Início
.text 

.globl main
main:

lui  $t0, 0x1001		# temp0 = 0x10010000
lw   $s0, 0x0 ($t0)		# a = MEM[0x10010000]
andi $s1, $s0, 0x1		# Resta apenas o primeiro bit
beq  $s1, $zero, par
j    fim
par:
j    fim
fim:
sw   $s1, 0x4 ($t0)		# MEM[0x10010004] = b

# Fim

.data 
a: .word 999
b: .word -1 
