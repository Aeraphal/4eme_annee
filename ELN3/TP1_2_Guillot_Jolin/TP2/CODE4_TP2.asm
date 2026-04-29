;-----------------------------------------------------------------------------
;  FILE NAME   : CODE4_TP2.asm
;  TARGET MCU  :  C8051F020
;  A FAIRE:
;
; IMPORTANT: à chaque fois qu'apparait "Concluez" vous devez ajouter dans ce fichier
; des explications sous forme de commentaire.
; - Tester le programme - Vérifier le calcul correct de la factorielle
; - Concluez : Pour chaque essai (1,2 et 3) indiquez les éléments suivants:
;          + taille maximale occupée par la pile en octet
;          + zone mémoire occupée par la pile (de la mémoire d'adresse XX
;            à la mémoire d'adresse YY)
;          + détailler le contenu de la pile (il ne s'agit pas de recopier
;            le contenu de la pile, mais d'expliquer à quoi ils correspondent)
;          + expliquer à quelle moment la pile a une taille maximale

;	Essai 1 : Calcul correct de la factorielle
; - La taille de la pile est de 7 octets 
; - La zone mémoire occupée par la pile va de la mémoire d'adresse 1bH
;   à la mémoire d'adresse 22H
; - Il correspond à un appel récursif de la fonction factorielle.
; - La pile atteint sa taille maximale à la fin de la fonction FACT


;	Essai 2 : 
; - La taille de la pile est de 12 octets 
; - La zone mémoire occupée par la pile va de la mémoire d'adresse 1bH
;   à la mémoire d'adresse 28H
; - Il correspond à un appel récursif de la fonction factorielle.
; - La pile atteint sa taille maximale au dernier appel de la fonction FACT (Le 3ème)


;	Essai 3 : 
; - La taille de la pile est de 28 octets 
; - La zone mémoire occupée par la pile va de la mémoire d'adresse 1bH
;   à la mémoire d'adresse 36H
; - Il correspond à un appel récursif de la fonction factorielle.
; - La pile atteint sa taille maximale au dernier appel de la fonction FACT (Le 11ème)


; - Concluez ou plutôt expliquez la consigne de segmentation relative à la pile
;   lignes 45 à 50 (voir Poly "Doc TP" chapitre "Macra assembleur 8051")
;Dans la partie idata on crée un segment nomé seg_stack et dans ce segment
;on créé une partie de taille 12
;   


; - Concluez: quels commentaires pouvez-vous faire sur la consigne de segmentation
;   de la pile donnée et sur l'utilisation effective de la file dans cet exercice
;   Proposez une solution corrective.
;Dans le tp la taiile de la pile effective est bien plus grande que celle qui lui est alloué initialement 
;pour corriger cela il suffit d'augmenter la taille de seg_stack lors de son initialisation à la taille
;maximale de la pile lors de l'utilisation de notre programme.
;   


;   Concluez - bilan de cet exercice - quels sont les règles à déduire de ct exercice
;   au sujet de la gestion de la pile? 
;Attention à bien prevoir la taille de la pile pour ne pas detruire d'autres informations.
;   


;-----------------------------------------------------------------------------
$include (c8051f020.inc)               ; Include register definition file.
;-----------------------------------------------------------------------------
; EQUATES
;-----------------------------------------------------------------------------
GREEN_LED      equ   P1.6              ; Port I/O pin connected to Green LED.
;-----------------------------------------------------------------------------
; Declarations Externes
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
; RESET and INTERRUPT VECTORS
;-----------------------------------------------------------------------------

               ; Reset Vector
               cseg AT 0          ; SEGMENT Absolu
               ljmp Main     ; Locate a jump to the start of code at 
                             ; the reset vector.
;-----------------------------------------------------------------------------
; DATA SEGMENT
;-----------------------------------------------------------------------------
 
Tab_zone       SEGMENT DATA     
               RSEG    Tab_zone  
Table_2:       DS 	20
;-----------------------------------------------------------------------------
; IDATA SEGMENT
;--------------------------------------------------------------------------
seg_stack       SEGMENT IDATA           ; seg_stack goes into IDATA RAM.
                RSEG    seg_stack          ; switch to seg_stack segment.
                DS      12              ; reserve 12 bytes in this example.
					
;-----------------------------------------------------------------------------
; CODE SEGMENT
;-----------------------------------------------------------------------------
Prog_base      segment  CODE

               rseg     Prog_base      ; Switch to this code segment.
               using    0              ; Specify register bank for the following
                                       ; program code
CPE: db'CPE LYON',0
ELN3: db'Bienvenue en TP ELN3',0
 	
;******************************************************************************
; Programme Principal
;******************************************************************************
Main:

      
		mov WDTCN, #0DEh    
        mov WDTCN, #0ADh
		mov SP,#seg_stack-1 ; la pile pointe sur le segment stack_seg (20 octets)
	
Main_BCL:	
; Essai 1 de SP_Factorial 
		mov  R7,#2
        call SP_Factorial 
        MOV  A,R7

; Essai 2 de SP_Factorial 
		mov  R7,#5
        call SP_Factorial 
        MOV  A,R7
		
; Essai 3 de SP_Factorial 
		mov  R7,#12
        call SP_Factorial 
        MOV  A,R7		

Main_no_carry:		
         jmp   Main_BCL



;******************************************************************************
; Zone réservée aux Sous programmes
;******************************************************************************

;******************************************************************************
; SOUS-PROGRAMME SP_Factorial
;
; Description: Sous-programme de calcul de Factorielle
;
; Paramètres d'entrée:  R7: valeur de factorielle à calculer
;						
;     
; Paramètres de sortie: R7 Résultat du calcul de factorielle
; Registres modifiés:  ?
; Pile: ? octets 
;******************************************************************************

;******************************************************************************	  
SP_Factorial:
       PUSH PSW
	   PUSH B
	   PUSH ACC
	   MOV A,R7
	   ACALL Fact
	   MOV R7,A
	   POP ACC
	   POP B
	   POP PSW
	   RET
;FIN SP SP_Factorial   
;******************************************************************************
Fact:  DEC R7
       CJNE R7,#01,Suit_Fact  ;value of R0 is compared with 1
       SJMP End_Fact          ;if R0=1, Fin SP Fact
Suit_Fact:
	   MOV B,R7
       MUL AB
       ACALL FACT ;calling back the same function
	   NOP
End_Fact:
       RET
;FIN SP Fact
;******************************************************************************	   
END
