inicio:   addi r0, r4, 1
					sw r0, r4, decode5
					lw r0, r3, keyboard
					beq r3, r2, selec
					beq r3, r1, programar
					j inicio

selec:   addi	r0, r4, 2
				 sw	r0, r4, decode5
				 j	escoger
				 addi	r0, r4, 3
				 sw	r0, r4, decode5
				 j	conteo
sonar:   sw	r0, r1, buzzer
				 lw r0, r3, keyboard
				 beq r3, r1, limpiar
				 j sonar

limpiar:   sw r0, r0, decode1
					 sw r0, r0, decode2
					 sw r0, r0, decode3
					 sw	r0, r0, decode4
					 j inicio

programar:   addi r0, r4, 2
						 sw r0, r4, decode5
						 addi r0, r4, 4
						 addi r0, r5, 8 
						 addi r0, r6, 4
						 addi r0, r7, 2
						 j seleccionProg
next:				 sw r0, r4, decode5
						 lw r0, r3, keyboard
						 beq r3, r5, ejercicio
						 beq r3, r6, descanso
						 beq r3, r7, guardar
						 j next


seleccionProg:  addi r0, r8, 2048; depronto hay que cambiar
								addi r0, r13, 2048
								addi r0, r14, 2124
								addi r0, r5, 8 
								addi r0, r6, 4
								addi r0, r7, 2
								addi r0, r10, 19
leerBotones			lw r0, r3, keyboard
								beq r3, r5, subir
								beq r3, r6, bajar
								beq r3, r7, enter
								j leerBotones
subir:					sub r8, r10, r12
								slt r12, r13, r9
								beq r9, r1, set5
								sub r8, r10, r8; revisar si esto si se puede
								j mostrar 
setLast:        addi r0, r8, 2124
mostrar:				lw r8, r11, address0
								sw r0, r11, decode0
								lw r8, r11, address1
								sw r0, r11, decode1
								lw r8, r11, address2
								sw r0, r11, decode2
								lw r8, r11, address3
								sw r0, r11, decode3
								j	leerBotones

bajar:					add r8, r10, r12
								slt r14, r12, r9
								beq r9, r1, setFirst
								add r8, r10, r8; revisar si esto si se puede
								j mostrar
setFirst:       addi r0, r8, 2048
								j mostrar
enter:					j next










								

								
