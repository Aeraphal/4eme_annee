;-----------------------------------------------------------------------------
;
;  FILE NAME   :  LIB_VOSSP_SM4.ASM 
;  TARGET MCU  :  C8051F020 
;  

;-----------------------------------------------------------------------------
$include (c8051f020.inc)               ; Include register definition file. 
;-----------------------------------------------------------------------------
;******************************************************************************
;Declaration des variables et fonctions publiques
;******************************************************************************
PUBLIC   _Read_code
PUBLIC   _Read_Park_IN
PUBLIC   _Read_Park_OUT
PUBLIC   _Decod_BIN_to_BCD
PUBLIC   _Display
PUBLIC   _Test_Code
PUBLIC   _Stockage_Code

;-----------------------------------------------------------------------------
; EQUATES
;-----------------------------------------------------------------------------
GREEN_LED      	equ   	P1.6             ; Port I/O pin connected to Green LED.

;-----------------------------------------------------------------------------
; CODE SEGMENT
;-----------------------------------------------------------------------------
ProgSP_base      segment  CODE

               rseg     ProgSP_base      ; Switch to this code segment.
               using    0              ; Specify register bank for the following
                                       ; program code.
;------------------------------------------------------------------------------
;******************************************************************************                
; _Read_code
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse du périphérique d’entrée
; Valeur retournée: R7 : contient la valeur du code lu (sur les 6 bits de poids faible). 
; Registres modifiés: aucun
;******************************************************************************    

_Read_code:
              PUSH ACC
			  PUSH DPL
			  PUSH DPH
			  MOV DPL, R7
			  MOV DPH, R6
			  MOVX A, @DPTR
			  CLR ACC.7
			  CLR ACC.0
			  RR A
			  MOV R7, A
			  POP DPH
			  POP DPL
			  POP ACC
              RET
;******************************************************************************    			  
			  
;******************************************************************************                
; _Read_Park_IN
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse du périphérique d’entrée
; Valeur retournée: Bit Carry  0: pas de détection / 1: véhicule détecté 
; Registres modifiés: aucun
;******************************************************************************    

_Read_Park_IN:
				PUSH ACC
				PUSH DPL
				PUSH DPH
				CJNE R0, #00H, Interruption1
				MOV DPL, R7
				MOV DPH, R6
				MOVX A, @DPTR
				MOV C, ACC.0				
				Interruption1:
				POP DPH
				POP DPL
				POP ACC
				RET
;******************************************************************************    						  
			  
;******************************************************************************                
; _Read_Park_OUT
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse du périphérique d’entrée
; Valeur retournée: Bit Carry  0: pas de détection / 1: véhicule détecté 
; Registres modifiés: aucun
;******************************************************************************    

_Read_Park_OUT:
				PUSH ACC
				PUSH DPL
				PUSH DPH
				CJNE R0, #00H, Interruption2

				MOV DPL, R7
				MOV DPH, R6			  
				MOVX A, @DPTR
				MOV C, ACC.7
				
				Interruption2:
				POP DPH
				POP DPL
				POP ACC
				RET
;****************************************************************************** 

;******************************************************************************                
; _Decod_BIN_to_BCD 
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse CODE de la table de conversion
;                                            "Display_7S"
; Paramètres d'entrée:  R5  – Valeur 4 bits à convertir (4bits de poids faible)
; Valeur retournée: R7 - Code 7 segments (Bit 0-Segment a __ Bit6-Segment g)
; Registres modifiés: aucun
;******************************************************************************    

_Decod_BIN_to_BCD:
				
				PUSH ACC
				PUSH DPL
				PUSH DPH
				CJNE R0, #00H, Interruption3

				MOV DPL, R7
				MOV DPH, R6
				MOV A, R5
				ANL A, #00001111b
				MOVC A, @A+DPTR
				CLR ACC.7
				MOV R7, A

				Interruption3:
				POP DPH
				POP DPL
				POP ACC
				RET
;****************************************************************************** 

;******************************************************************************                
; _Display  
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse du périphérique de sortie
; Paramètre d’entrée :  R5 – Code 7 segments (les 7 bits de poids faible)
; Paramètre d’entrée :  R3 – Code LED : si 0, LED éteinte, si non nul : LED allumée
; Valeur retournée: R7 : contient une recopie de la valeur envoyée au périphérique de sortie. 
; Registres modifiés: aucun
;******************************************************************************    

_Display:
				PUSH ACC
				PUSH DPL
				PUSH DPH
				CJNE R0, #00H, Interruption4

				MOV DPL, R7
				MOV DPH, R6
				MOV A, R3
				JZ Affichage
				MOV A, R5
				SETB ACC.7
				MOVX @DPTR, A
				MOV R7, A

				Interruption4:
				POP DPH
				POP DPL
				POP ACC
				
				RET
			  
Affichage:
				MOV A, R5
				CLR ACC.7
				MOVX @DPTR, A
				MOV R7, A

				POP DPH
				POP DPL
				POP ACC
				RET 
;****************************************************************************** 

;******************************************************************************                
; _Test_Code  
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse de Tab_code
; Paramètre d’entrée :  R5  – Code à vérifier (sur 6 bits)
; Valeur retournée: R7 : non nul, il retourne la position du code trouvé dans la table,
;                        nul, il indique que le code n’a pas été trouvé dans la table.
; Registres modifiés: aucun
;******************************************************************************    

_Test_Code:
				PUSH ACC
				PUSH DPL
				PUSH DPH
				PUSH AR4
				CJNE R0, #00H, Interruption5

				MOV DPL, R7
				MOV DPH, R6
				CLR A

				MOVC A, @A + DPTR
				MOV R4, A

				boucle:
				MOV A, R4
				MOVC A, @A + DPTR
				ANL A, #00111111b
				CJNE A, AR5, saut
				SJMP Verif
				saut:
				DJNZ R4, boucle
				MOV R7, #00h

				Interruption5:
				POP AR4
				POP DPH
				POP DPL
				POP ACC
				RET

Verif:
				MOV R7, AR4
				POP AR4
				POP DPH
				POP DPL
				POP ACC
				RET
;****************************************************************************** 

;******************************************************************************                
; _Stockage_Code 
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse de Tab_histo
; Paramètre d’entrée :  R5 – Code à enregistrer
; Valeur retournée: R7 : R7 : non nul, il retourne le nombre d’enregistrements,
;                             nul, il indique que la table est pleine (100 enregistrements). 
; Registres modifiés: aucun
;******************************************************************************    

_Stockage_Code:
				PUSH ACC
				PUSH DPL
				PUSH DPH
				CJNE R0, #00H, Interruption6
				
				
				MOV DPL, R7
				MOV DPH, R6
				MOVX A,@DPTR
				CJNE A,#64h,table_non_pleine
				SJMP table_pleine
				table_non_pleine:
				INC A
				MOVX @DPTR, A
				MOV R7,A
				CLR C
				ADDC A, DPL
				MOV DPL, A
				CLR A
				ADDC A, DPH
				MOV DPH,A
				MOV A, R5
				MOVX @DPTR, A

				Interruption6:
				POP DPH
				POP DPL
				POP ACC
				RET
table_pleine:
				MOV R7, #00h
				POP DPH
				POP DPL
				POP ACC
				RET
;****************************************************************************** 


END



