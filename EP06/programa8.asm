# Programa 08
# $8	= 0x12345678
# $9	= 0x12 
# $10	= 0x34 
# $11	= 0x56 
# $12	= 0x78 

# Início

.text
.globl main
main:

lui  $t5, 0x1234		# $temp5 = 0x12340000
ori  $8,  $t5,    0x5678	# $8     = 0x12345678

srl  $9,  $8,     24		# $9     = 0x00000012
srl  $t5, $8,     16		# $temp5 = 0x00001234
andi $10, $t5,    0xFF		# $10    = 0x00000034
srl  $t5, $8,     8		# $temp5 = 0x00123456
andi $11, $t5,    0xFF		# $11    = 0x00000056
andi $12, $8,     0xFF		# $12    = 0x00000078

# Fim
