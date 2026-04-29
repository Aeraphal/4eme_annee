;-----------------------------------------------------------------------------
;  FILE NAME   : CODE2_TP2.asm
;  TARGET MCU  :  C8051F020
;  A FAIRE:

; IMPORTANT: à chaque fois qu'apparait "Concluez" vous devez ajouter dans ce fichier
; des explications sous forme de commentaire.

; - Tester le programme en laissant en commentaire les 2 appels
;   de sous-programme (les 2 CALL en commentaire)
;   Visualiser l'évolution de XDATA en faisant une exécution avec points d'arrêt 
;   (Placer le point d'arrêt sur le MOVX du programme principal
;   et faites des "run" successifs pour observer le remplissage progressif de la XDATA 
;   à partir de l'adresse 0
;   Concluez: que fait le programme principal?

;	Le programme principale compte rempli progressivement XDATA à partir de l'adresse 0 
;	en commençant par l'index 01. Puis il incrémente cet index à l'adresse suivante indéfiniment.


; - Décommenter les 2 lignes qui appellent les sous-programmes et tester de 
;   nouveau le code. S'assurer que le Sous-Programme strlen_CODE fonctionne correctement
;   Mais, le fonctionnement du programme principal devrait être affecté, la mémoire
;   XDATA ne se remplissant plus comme prévu
;   Concluez: que se passe t'il désormais dans la XDATA?

;	A cause du sous programme strlen_CODE, seul l'indice #000C de la mémoire XDATA change pour
;	devenir 14. Cela s'explique car on impose la valeur #0FFH à R5. R5 étant utilisé dans le
;	programme principale pour écrire dans XDATA. Et comme il est toujours réinitialiser à chaque
;	fois que l'on utilise le sous programme strlen_CODE plutôt que de s'incrémenter en bouche, 
;	alors cela pose problème dans la mémoire XDATA. 


; - Analyser le problème et intervenir sur le contenu du sous-programme pour 
;   résoudre le problème
;   Concluez: expliquez le problème et la méthode de résolution adoptée 

;	Le problème est expliqué précédemment. Le premier appel de strlen_CODE affecte 08 à l'index
;	0003 de la mémoire X, correspondant ainsi "CPE LY". Le deuxième appel de strlen_CODE affecte
;	14 à l'index 000C de la mémoire X, correspondant ainsi à "Bienvenue". Nous allons stocker
;	dans une pile les incrémentations afin de ne pas les écraser par les manipulations de strlen_CODE.

; - Une piste de réflexion: Vu du programme appelant, le sous-programme ne doit
;   pas modifier le contenu de registres. Il faut donc que le SP les sauvegarde 
;   au début de son exécution et les restore à la fin. Comme lieu de stockage,
;   pensez "pile"...
;
; - Après les modifications, testez le bon fonctionnement du programme principal
;   et du sous-programme.
; 
; - Concluez: quelles sont les règles à mettre en place quand on code un sous-programme

;	Les règles à mettre en place quand on code un sous-programme sont les suivantes : 
; - Vérifier qu'aucune commande du sous-programme écrase des valeurs du programme principale essentiel
;	à son bon fonctionnement.
; - Ne pas hésiter à effectuer des sauvegardes à l'aide de piles si nécessaire.

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
; CODE SEGMENT
;-----------------------------------------------------------------------------


Prog_base      segment  CODE

               rseg     Prog_base      ; Switch to this code segment.
               using    0              ; Specify register bank for the following
                                       ; program code.

CPE: db'CPE LYON',0
ELN3: db'Bienvenue en TP ELN3',0
 	
;******************************************************************************
; Programme Principal
;******************************************************************************
Main:
		mov WDTCN, #0DEh    
        mov WDTCN, #0ADh
		MOV DPTR,  #0
		mov A,#0	
		mov R4,#0
		mov R5,#1
Main_BCL:	
; Essai 1 de strlen_CODE
        mov  R6,#High(CPE)  ; Partie haute de l'adresse CPE
		; Pour la signification des expressions HIGH et LOW, regarder dans l'aide en ligne
		; de microvision à la Rubrique:
		; "Ax51 Assembly User's Guide/Writing Assembly Programs/Expressions and Operators/Operators"
		mov  R7,#Low(CPE)   ; Partie basse de l'adresse CPE
       call strlen_CODE
        MOV  A,R7
		ADD  A,R4
		mov  R4,A
; Essai 2 de strlen_CODE	
        mov  R6,#High(ELN3)  ; Partie haute de l'adresse CPE
		mov  R7,#Low(ELN3)   ; Partie basse de l'adresse CPE
;        call strlen_CODE
        MOV  A,R7
		ADD  A,R4
		mov  R4,A
; Ecriture dans XDATA		
        MOV  A,R5  
        MOVX @DPTR,A
        INC DPTR
		INC R5
Main_no_carry:		
         jmp   Main_BCL

;******************************************************************************
; Zone réservée aux Sous programmes
;******************************************************************************

;******************************************************************************
; SOUS-PROGRAMME strlen_CODE
;
; Description: Sous-programme de determination de la longueur d'une chaine de 
;              caractère stockée dans l'espace CODE. La taille calculée ne tient 
;              pas compte du caractère NULL (0)
;
; Paramètres d'entrée:  R6-R7: Adresse de la chaine (R6 poids fort, R7 poids faible)
;						
;     
; Paramètres de sortie: R7 Taille de la chaine
; Registres modifiés:  ?
; Pile: ? octets 
;******************************************************************************
strlen_CODE:
	
	  push AR5
	  push ACC  
	  push DPL
	  push DPH
	  push PSW
	  
      mov DPH,R6
      mov DPL,R7
      mov R5,#0FFH
BCL1_strlen_CODE:
      inc R5
      mov A,R5
      movc A,@A+DPTR  
      jnz BCL1_strlen_CODE
	  mov R7,AR5    
	 
	  POP PSW
	  POP DPH 
	  POP DPL
	  POP ACC
	  POP AR5
	 
	 ; même chose que mov R7,05H
	  ret
; FIN SP strlen_CODE
;******************************************************************************	  

END
