#TODO: Cambiar los registros de apuntadores a registros s0..n, por si acaso.
# o más bien, definir bien con qué voy a usar cada cosa, para que no se nos
# crucen los usos entre registros.

#TODO: Poner la selección de sesiones desde un principio en el bloque del inicio,
# o algo parecido como eso. No tendríamos que cambiar cosas en el diagrama, si nos
# quedamos callados y tal.

.data
DIGIT: # DIGITOS CODIFICADOS EN 7 SEGMENTOS #
.byte   0x7e, 0x06, 0x6d, 0x79, 0x33, 0x5b, 0x5f, 0x70, 0x7f, 0x7b
# Los digitos están en orden (0, 1, 2, 3, ..., 9)

CHAR: # CARACTERES CODIFICADOS EN 7 SEGMENTOS #
.byte 0x77, 0x4e, 0x4e, 0x5e, 0x17, 0x0e, 0x76, 0x1d, 0x67, 0x05, 0x5b, 0x0f, 0x37
# Los caracteres son A, C, E, G, h, L, N, o, P, r, S, t, X, respectivamente.

# A:0
# C:1
# E:2
# G:3
# h:4
# L:5
# N:6
# o:7
# P:8
# r:9
# S:10
# t:11
# X:12

.text
INICIO:
    la $t0, CHAR

    # Mostrar HOLA
    lw $t1, 4($t0)
    sw $t1, 0xFFF0($0)
    lw $t1, 7($t0)
    sw $t1, 0xFFF1($0)
    lw $t1, 5($t0)
    sw $t1, 0xFFF2($0)
    lw $t1, 0($t0)
    sw $t1, 0xFFF3($0)

    # Leer botones
    lw $t2, 0xFFFC

    addi $t3, $0, 1
    beq $t2, $t3, PROG

    addi $t3, $0, 2
    beq $t2, $t3, OPER

# Podríamos tratar de hacer una pseudo-función, pero es mejor repetir
# el código en cada caso, porque éste también lo tendremos que hacerle
# unas cuantas modificaciones.

PROG:
    # Mostrar SELC
    sw $t1, 0xFFF0($0)
    lw $t1, 10($t0)
    lw $t1, 2($t0)
    sw $t1, 0xFFF1($0)
    lw $t1, 5($t0)
    sw $t1, 0xFFF2($0)
    lw $t1, 1($t0)
    sw $t1, 0xFFF3($0)

    # Creo que nos va a tocar poner un label por aquí, O hacer lo de la selección
    # Desde un principio para los dos casos.
    # Sí. es una buena idea
    # Seleccionar sesión a editar
    # ...
    addi $s0, $0, 0

    # Leer botones
    lw $t2, 0xFFFC

    addi $t3, $0, 1
    beq $t2, $t3, OTHER_LB

    addi $t3, $0, 2
    beq $t2, $t3, OTHER_LB          # Los botones fijan un bit en un shift register. Por eso las potencias de 2

    addi $t3, $0, 4
    beq $t2, $t3, OTHER_LB

    addi $t3, $0, 4
    beq $t2, $t3, OTHER_LB
    ... #


    # Mostar NEXT
    lw $t1, 10($t0)
    sw $t1, 0xFFF0($0)
    lw $t1, 2($t0)
    sw $t1, 0xFFF1($0)
    lw $t1, 5($t0)
    sw $t1, 0xFFF2($0)
    lw $t1, 1($t0)
    sw $t1, 0xFFF3($0)

    # Leer botones
    # Saltar a circuito de ejercícios
    # Edición de descanso
    # Guardar datos en sesión

OPER:
    # Mostrar SELC
    lw $t1, 10($t0)
    sw $t1, 0xFFF0($0)
    lw $t1, 2($t0)
    sw $t1, 0xFFF1($0)
    lw $t1, 5($t0)
    sw $t1, 0xFFF2($0)
    lw $t1, 1($t0)
    sw $t1, 0xFFF3($0)

    # ...
    # Seleccionar sesión a correr

    # Mostar OPER
    lw $t1, 7($t0)
    sw $t1, 0xFFF0($0)
    lw $t1, 8($t0)
    sw $t1, 0xFFF1($0)
    lw $t1, 2($t0)
    sw $t1, 0xFFF2($0)
    lw $t1, 9($t0)
    sw $t1, 0xFFF3($0)

    # Cargar duraciones en temporizador
    # Trigger temporizador clock
    # Saltar al ciclo que verifica si el clock se ha acabado
