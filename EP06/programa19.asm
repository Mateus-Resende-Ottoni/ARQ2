# Programa 19
# Ler $s0 e $s1, determinar bits significantes
# Multiplicar e guardar

# Associações
# x -> $s0
# y -> $s1

# Início

.text

.globl main
main:
lui  $t2, 0x1001
lw   $s0,     0 ($t2)		# x = MEM[0x1001000]
lw   $s1,     4 ($t2)		# y = MEM[0x1001004]
addi $sp,   $sp, -4
sw   $t2,     4 ($sp)		# sp[0] = t2
or   $a0,   $s0, $zero		# a0 = x
jal  bits_significantes
nop
lw   $t2,     4 ($sp)		# t2 = sp[0]
addi $sp,   $sp,  4
or   $t0,   $v0, $zero		# t0 = bits_significantes(x)
addi $sp,   $sp, -8
sw   $t0,     8 ($sp)		# sp[0] = t0
sw   $t2,     4 ($sp)		# sp[1] = t2
or   $a0,   $s1, $zero		# a0 = y
jal  bits_significantes
nop
lw   $t0,     8 ($sp)		# t0 = sp[0]
lw   $t2,     4 ($sp)		# t2 = sp[1]
addi $sp,   $sp,  8
or   $t1,   $v0, $zero		# t1 = bits_significantes(y)
add  $t3,   $t0, $t1		# t3 = t1 + t2
mult $s0,   $s1			# x * y
addi $t4, $zero, 32		# t4 = 32
slt  $t4,   $t3, $t4		# t3 < 32 (?)
beq  $t4, $zero, mais32		# Se maior que 32, desviar
mflo $s2			# $s2 = $lo
j    fim
mais32:
mflo $s2			# $s2 = $lo
mfhi $s3			# $s2 = $hi
j    fim

bits_significantes:
or   $t0,   $a0, $zero		# t0 = a0
or   $t1, $zero, $zero		# t1 = 0
srl  $t2,   $a0, 31		# Bit do sinal
bne  $t2, $zero, negativo	# Se for 1(negativo), outro método
for_plus:
beq  $t0, $zero, fim_bits	# Se t0==0, acabar processo
srl  $t0,   $t0, 1		# t0>>
addi $t1,   $t1, 1		# t1 = t1 + 1
j for_plus			# Repetir loop
negativo:
addi $t2, $zero, -1		# t2 = -1
for_minus:
beq  $t0,   $t2, fim_bits		# Se t0==-1, acabar processo
sra  $t0,   $t0, 1		# t0>>
addi $t1,   $t1, 1		# t1 = t1 + 1
j for_minus			# Repetir loop
fim_bits:
add  $v0,   $t1, $zero		# v0 = t1
jr $ra


fim:
addi $v0, $zero, 10
syscall

# Fim

.data
x: .word  6
y: .word -2
