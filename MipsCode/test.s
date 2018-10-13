    .data
        ## DIGITOS CODIFICADOS EN 7 SEGMENTOS ##
        ZERO:   .byte   0x7e
        ONE:    .byte   0x06
        TWO:    .byte   0x6d
        TREE:   .byte   0x79
        FOUR:   .byte   0x33
        FIVE:   .byte   0x5b
        SIX:    .byte   0x5f
        SEVEN:  .byte   0x70
        EIGHT:  .byte   0x7f
        NINE:   .byte   0x7b

        ## CARACTERES CODIFICADOS EN 7 SEGMENTOS ##
        # -- Podriamos cambiar todas las letras a lowercase
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
        T:  .byte   0x0f
        X:  .byte   0x37 # Uppercase

    .text
INICIO:
    # MAIN del programa...
