TITLE	MAIN PROGRAM
LINES 50
;-----------------------
; PROGRAM AREA
;-----------------------
inicio: addi r0, r4, n1
sw r0, r4, decode5%:
lw r0, r3, keyboard
beq r3, r2, selec
beq r3, r1, programar
j inicio

selec: addi r0, r4, 2
sw r0, r4, decode5
j escoger
oper: addi r0, r4, 3
sw r0, r4, decode5
j conteo
sonar: sw r0, r1, buzzer
lw r0, r3, keyboard
beq r3, r1, limpiar
j sonar

limpiar: sw r0, r0, decode1
sw r0, r0, decode2
sw r0, r0, decode3
sw r0, r0, decode4
j inicio

programar: addi r0, r4, 2
sw r0, r4, decode5
addi r0, r4, 4
addi r0, r5, 8 
addi r0, r6, 4
addi r0, r7, 2
j seleccionProg
addi r8, r20, 4 
next: sw r0, r4, decode5
readKeys: lw r0, r3, keyboard
beq r3, r5, ejercicio
beq r3, r6, descanso
beq r3, r7, guardar
j next

guardar: j inicio

seleccionProg: addi r0, r8, 2048 ; depronto hay que cambiar algo
addi r0, r13, 2048
addi r0, r14, 2124
addi r0, r5, 8 
addi r0, r6, 4
addi r0, r7, 2
addi r0, r10, 19
leerBotones: lw r0, r3, keyboard

beq r3, r5, subir
beq r3, r6, bajar
beq r3, r7, enter
j leerBotones
subir: sub r8, r10, r12
slt r12, r13, r9
beq r9, r1, setLast
sub r8, r10, r8 ; revisar si esto si se puede
j mostrar
setLast: addi r0, r8, 2124
mostrar: lw r8, r11, address0
sw r0, r11, decode0
lw r8, r11, address0
sw r0, r11, decode1
lw r8, r11, address1
sw r0, r11, decode2
lw r8, r11, address2
sw r0, r11, decode3
j leerBotones
bajar: add r8, r10, r12
slt r14, r12, r9
beq r9, r1, setFirst
add r8, r10, r8; revisar si esto si se puede
j mostrar
setFirst: addi r0, r8, 2048 j mostrar
enter: j next

ejercicio: addi r0, r4, 5
sw r0, r4, decode5
addi r0, r9, 0; count
addi r0, r5, 8 
addi r0, r6, 4
addi r0, r7, 2
addi r0, r12, 59
readKeysSec: lw r0, r3, keyboard
beq r3, r5, up
beq r3, r6, down
beq r3, r7, save
j readKeysSec
up: add r1, r9, r10
slt r12, r10, r11
beq r11, r1, set0
add r9, r1, r9
j showSeconds
set0: addi r0, r9, 0
j showSeconds
down: sub r9, r1, r10
slt r10, r0, r11
beq r11, r1, setLimit
sub r9, r1, r9
j showSeconds
setLimit: addi r0, r9, 59
j showSeconds
showSeconds: sw r0, r9, decode0
j readKeysSec

save: sw r20, r9, address0
j ejercicioMin

ejercicioMin: addi r0, r4, 6
sw r0, r4, decode5
addi r0, r9, 0; count
addi r0, r5, 8 
addi r0, r6, 4
addi r0, r7, 2
addi r0, r12, 59
readKeysMin: lw r0, r3, keyboard
beq r3, r5, up1
beq r3, r6, down1
beq r3, r7, save1
j readKeysMin
up1: add r1, r9, r10
slt r12, r10, r11
beq r11, r1, set0
add r9, r1, r9
j showMin
set0: addi r0, r9, 0
j showMin
down1: sub r9, r1, r10
slt r10, r0, r11
beq r11, r1, setLimit1
sub r9, r1, r9
j showMin
setLimit1: addi r0, r9, 59
j showMin
showMin: sw r0, r9, decode1
j readKeysMin

save1: sw r20, r9, address1
addi r0, r21, 3
add r20, r21, r20
j readKeys

descanso: addi r0, r4, 5
sw r0, r4, decode5
addi r0, r9, 0; count
addi r0, r5, 8 
addi r0, r6, 4
addi r0, r7, 2
addi r0, r12, 59
readKeysSecDes: lw r0, r3, keyboard
beq r3, r5, upDes
beq r3, r6, downDes
beq r3, r7, saveDes
j readKeysSecDes
upDes: add r1, r9, r10
slt r12, r10, r11
beq r11, r1, set0
add r9, r1, r9
j showSecondsDes
set0: addi r0, r9, 0
j showSecondsDes
downDes: sub r9, r1, r10
slt r10, r0, r11
beq r11, r1, setLimit
sub r9, r1, r9
j showSecondsDes
setLimit: addi r0, r9, 59
j showSecondsDes
showSecondsDes: sw r0, r9, decode0
j readKeysSecDes

saveDes: sw r20, r9, address0
j ejercicioMin

descansoMin: addi r0, r4, 6
sw r0, r4, decode5
addi r0, r9, 0; count
addi r0, r5, 8 
addi r0, r6, 4
addi r0, r7, 2
addi r0, r12, 59
readKeysMinDes: lw r0, r3, keyboard
beq r3, r5, up1Des
beq r3, r6, down1Des
beq r3, r7, save1Des
j readKeysMinDes
up1Des: add r1, r9, r10
slt r12, r10, r11
beq r11, r1, set0
add r9, r1, r9
j showMinDes
set0: addi r0, r9, 0
j showMinDes
down1Des: sub r9, r1, r10
slt r10, r0, r11
beq r11, r1, setLimit1
sub r9, r1, r9
j showMinDes
setLimit1: addi r0, r9, 59
j showMinDes
showMinDes: sw r0, r9, decode1
j readKeysMinDes

save1Des: sw r20, r9, address1
addi r0, r21, 3
add r20, r21, r20
j readKeys

escoger: addi r0, r8, 2048 ; depronto hay que cambiar algo
addi r0, r13, 2048
addi r0, r14, 2124
addi r0, r5, 8 
addi r0, r6, 4
addi r0, r7, 2
addi r0, r10, 19
leerBotones1: lw r0, r3, keyboard

beq r3, r5, subir1
beq r3, r6, bajar1
beq r3, r7, enter1
j leerBotones1
subir1: sub r8, r10, r12
slt r12, r13, r9
beq r9, r1, setLast1
sub r8, r10, r8 ; revisar si esto si se puede
j mostrar1
setLast1: addi r0, r8, 2124
mostrar1: lw r8, r11, address0
sw r0, r11, decode0
lw r8, r11, address0
sw r0, r11, decode1
lw r8, r11, address1
sw r0, r11, decode2
lw r8, r11, address2
sw r0, r11, decode3
j leerBotones1
bajar1: add r8, r10, r12
slt r14, r12, r9
beq r9, r1, setFirst1
add r8, r10, r8; revisar si esto si se puede
j mostrar1
setFirst1: addi r0, r8, 2048 j mostrar1
enter1: j oper