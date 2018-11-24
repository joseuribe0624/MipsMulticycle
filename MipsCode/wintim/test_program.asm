TITLE	MAIN PROGRAM
LINES 50
;-----------------------
; PROGRAM AREA
;-----------------------
inicio: addi r0, r4, B#0000000000000001
sw r0, r4, inicio%:
lw r0, r3, inicio%:
beq r3, r2, inicio%:
beq r3, r1, inicio%:
j inicio%: