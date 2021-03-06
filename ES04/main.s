;==========================================================================================
; Project:  <nome del progetto/modulo/file>
; Date:     <data>
; Author:   <autore>
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  <inserire una breve descrizione del progetto/modulo/libreria>
;  <specifiche del progetto/modulo/libreria>
;  <specifiche del collaudo>
;
; Ver   Date        Comment
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 1.0   24/10/16    Versione iniziale
; <Descrivere per ogni revisione o cambio di versione le modifiche apportate>
; 
;==========================================================================================
;------------------------------------------------------------------------------------------
;=== COSTANTI =============================================================================
;------------------------------------------------------------------------------------------

	THUMB
;------------------------------------------------------------------------------------------
;=== AREA DATI RAM ========================================================================
;------------------------------------------------------------------------------------------
	AREA MyDataRam, DATA, ALIGN = 2
 
;------------------------------------------------------------------------------------------
;=== AREA DATI FLASH ======================================================================
;------------------------------------------------------------------------------------------
	AREA MyDataFlash, CODE, ALIGN = 2

;------------------------------------------------------------------------------------------
;=== AREA ISTRUZIONI ======================================================================
;------------------------------------------------------------------------------------------
	AREA MyCode, CODE, READONLY
	;------------------
	; EXPORT/IMPORT
	;------------------
	EXPORT __main

	ENTRY
;------------------------------------------------------------------------------------------
;=== MAIN ROUTINE =========================================================================
;------------------------------------------------------------------------------------------
__main

	MOV R1#0x20
	MOVT R1#0x2000
	MOV R0#0xFEDE
	MOVT R0#0xABB1
	LDR R0,[R1]
	
stop B stop
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ALIGN
	END

	

