# Programa 07
# $8 = 0xFFFFFFFF

# Início

.text
.globl main
main:

ori $8,  $0,  0x01	# $8 = 0x00000001
sll $t0, $8,  31	# $8 = 0x10000000
sra $8,  $t0, 31	# $8 = 0x11111111

# Fim
