# Programa 16
# x = 1600000 (=0x186A00), y = 80000 (=0x13880), e z = 400000 (=0x61A80)
# (x*y)/z

# Associações
# x -> $s0
# y -> $s1
# z -> $s2
# resposta -> $s3

# Início

.text

.globl main
main:
lui  $t0, 0x1001		# t0 = 0x10010000
lw   $s0,  0 ($t0)		# x = 1600000 (=0x186A00)
lw   $s1,  4 ($t0)		# y = 80000 (=0x13880)
lw   $s2,  8 ($t0)		# z = 400000 (=0x61A80)
div  $s0, $s2			# x/z
mflo $t0			# t0 = x/z
mult $t0, $s1			# t0*y
mflo $s3			# resposta = t0*y = x*y/z
sw   $s3, 12 ($t0)		# MEM[0x100100c] = resposta

# Fim

.data
x: .word 0x186A00
y: .word 0x13880
z: .word 0x61A80
