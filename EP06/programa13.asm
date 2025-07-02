# Programa 13

# Associações
# A -> $s0

# Início
.text 

.globl main
main:
lui  $t0, 0x1001		# temp0 = 0x10010000
lw   $s0, 0x0 ($t0)		# a = MEM[0x10010000]
srl  $t1, $s0, 31		# Resta apenas o primeiro bit
andi $t1, $t1, 0x1		# 0 se positivo, 1 se negativo
beq  $t1, $zero, fim		# Se positivo, pular inversão
sub  $s0, $zero, $s0		# a = 0 - a
fim:
sw   $s0, 0x0 ($t0)		# MEM[0x10010000] = a

# Fim

.data 
a:  .word -999
