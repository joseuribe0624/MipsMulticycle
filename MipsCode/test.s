    .data
# DIGITOS CODIFICADOS EN 7 SEGMENTOS #
DIGIT:  .byte   0x7e, 0x06, 0x6d, 0x79, 0x33, 0x5b, 0x5f, 0x70, 0x7f, 0x7b
# Los digitos están en orden (0, 1, 2, 3, ..., 9)

# CARACTERES CODIFICADOS EN 7 SEGMENTOS #
A:  .byte   0x77
C:  .byte   0x4e
E:  .byte   0x4f
G:  .byte   0x5e
H:  .byte   0x17 # Lowercase
L:  .byte   0x0e
N:  .byte   0x76
O:  .byte   0x1d # Lowercase
P:  .byte   0x67
R:  .byte   0x05 # Lowercase
S:  .byte   0x5b # Igual que el digito '5' (6 + DIGIT)
T:  .byte   0x0f # Lowercase
X:  .byte   0x37 # Uppercase (enrealidad es una H)


    .text
INICIO:
    # MAIN del programa...
