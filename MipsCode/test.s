.data
DIGIT: # DIGITOS CODIFICADOS EN 7 SEGMENTOS #
.byte   0x7e, 0x06, 0x6d, 0x79, 0x33, 0x5b, 0x5f, 0x70, 0x7f, 0x7b
# Los digitos están en orden (0, 1, 2, 3, ..., 9)

CHAR: # CARACTERES CODIFICADOS EN 7 SEGMENTOS #
.byte 0x77, 0x4e, 0x4e, 0x5e, 0x17, 0x0e, 0x76, 0x1d, 0x67, 0x05, 0x5b, 0x0f, 0x37
# Los caracteres son A, C, E, G, h, L, N, o, P, r, S, t, X, respectivamente.

.text
INICIO:
la $t0, CHAR

# Mostrar HOLA
lb $t1, 4($t0)
sb $t1, 0xFFFFFFF0($0)
lb $t1, 7($t0)
sb $t1, 0xFFFFFFF1($0)
lb $t1, 5($t0)
sb $t1, 0xFFFFFFF2($0)
lb $t1, 0($t0)
sb $t1, 0xFFFFFFF3($0)

# Leer botones
lb $t2, 0xFFFFFFFA

addi $t3, $0, 1
beq $t2, $t3, PROG

addi $t3, $0, 2
beq $t2, $t3, OPER

# CHAR:  .byte   0x77
# C:  .byte   0x4e
# E:  .byte   0x4f
# G:  .byte   0x5e
# H:  .byte   0x17 # Lowercase
# L:  .byte   0x0e
# N:  .byte   0x76
# O:  .byte   0x1d # Lowercase
# P:  .byte   0x67
# R:  .byte   0x05 # Lowercase
# S:  .byte   0x5b # Igual que el digito '5' (6 + DIGIT)
# T:  .byte   0x0f # Lowercase
# X:  .byte   0x37 # Uppercase (enrealidad es una H)
