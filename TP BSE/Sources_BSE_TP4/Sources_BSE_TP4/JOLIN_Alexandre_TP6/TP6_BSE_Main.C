//*****************************************************************************
// Fichiers d'entête
#include "intrins.h"
#include<c8051F020.h>
#include<c8051F020_SFR16.h>
#include<TP6_BSE_Lib_Config_Globale.h>
#include<TP6_BSE_Lib_Divers.h>
#include<TP6_BSE_Main.h>
//-----------------------------------------------------------------------------
// Déclaration des MACROS

#define SYSCLK 22118400L
#define BP_ON 0
#define BP_OFF 1
#define TO_BE_PROCESSED 1
#define PROCESSED 0
#define SET_VISU_INT6 P6 |= (1<<4)
#define RESET_VISU_INT6 P6 &= ~(1<<4)
//-----------------------------------------------------------------------------
// Déclarations Registres et Bits de l'espace SFR
sbit VISU_INT7 = P2^4;
sbit VISU_INT_TIMER2 = P3^5;
sbit VISU_INT_TIMER4 = P3^4;
sbit SIG_OUT = P3^3;
//-----------------------------------------------------------------------------
// Variables globales

bit Event = PROCESSED;  // Détection des évènements pour changer le clignotement de la LED
unsigned int Event_to_Count = 100 ; //Valeur du comptage d'évènements 
long frequence = 0;  // Fréquence calculée de SIG_IN
unsigned int CP_Overflow_Timer4; // Compteur d'overflows du Timer4
//-----------------------------------------------------------------------------
// MAIN Routine
//-----------------------------------------------------------------------------
void main (void) {
	


 	   // Configurations globales
	      Init_Device();
	     
	   // Configurations  spécifiques  
	      Config_INT7(); // Configuration de INT7
	      Config_INT6(); // Configuration de INT6
	      Config_Timer2_TimeBase();
        Config_Timer4_Event_Counter();
	   // Fin des configurations
	      
	      EA = 1;  // Validation globale des interruptions
	
// Boucle infinie	
         while(1) {
						
				 
				 }
      				               	
			}
//******************************************************************************
void Config_INT7(void)
{
	P3IF &= ~(1<<7); // IE7 mis à 0 pending flag de INT7 effacé
	P3IF &= ~(1<<3); // IE7CF mis à 0 - sensibilité int7 front descendant	
	
	EIP2 &= ~(1<<5);  // PX7 mis à 0 - INT7 priorité basse
	EIE2 |= (1<<5);  // EX7 mis à 1 - INT7 autorisée
}
//******************************************************************************
void ISR_INT7 (void) interrupt 19
{
	VISU_INT7 = 1;
	P3IF &= ~(1<<7); // IE3 mis à 0 - remise à zéro du pending flag de INT7 effacé
	Event = TO_BE_PROCESSED;
	VISU_INT7 = 0;
}	

//*****************************************************************************	 
//******************************************************************************
void Config_INT6(void)
{
	P3IF &= ~(1<<7); // IE6 mis à 0 pending flag de INT6 effacé
	P3IF &= ~(1<<2); // IE6CF mis à 0 - sensibilité int6 front descendant	
	
	EIP2 &= ~(1<<4);  // PX6 mis à 0 - INT7 priorité basse
	EIE2 |= (1<<4);  // EX6 mis à 1 - INT7 autorisée
}

//******************************************************************************
void ISR_INT6 (void) interrupt 18
{
	SET_VISU_INT6;
	P3IF &= ~(1<<6); // IE6 mis à 0 - remise à zéro du pending flag de INT6 effacé
	P3IF ^= (1<<2);   // Action sur IE6CF - Commutation Front montant / Front Descendant
	Event = TO_BE_PROCESSED;
	RESET_VISU_INT6;
}	

//*****************************************************************************	 
//******************************************************************************
void Config_Timer2_TimeBase(void)
{
	CKCON &= ~(1<<5);         // T2M: Timer 2 Clock Select
                         // CLK = sysclk/12TR2 = 0;  //Stop Timer
	TF2 = 0;  // RAZ TF2
	EXF2 = 0;  // RAZ EXF2
  RCLK0 = 0;         
  TCLK0 = 0;
  CPRL2 = 0;  // Mode AutoReload	
	EXEN2 = 0;   // Timer2 external Enable Disabled 
  CT2 = 0;    // Mode Timer

	RCAP2 = -((SYSCLK/12)/100);
  T2 = RCAP2;
  TR2 = 1;                           // Timer2 démarré
  PT2 = 1;							  // Priorité Timer2 Haute

   ET2 = 1;							  // INT Timer2 autorisée
}

//******************************************************************************
void ISR_Timer2 (void) interrupt 5
{
	static char CP_Seconde = 0;
	char Read_Cfg_Event;
	static unsigned int CP_Timer4 = 0;
	static unsigned int OLD_CP_Timer4 = 0;

	VISU_INT_TIMER2 = 1;
	
	
	if (TF2 == 1)
	{
		TF2 = 0;
	
	// Gestion de la mesure de frequence - Synthèse
  // Le calcul de la fréquence est fait toutes les secondes		
	CP_Seconde++;
	if (CP_Seconde >= 100) 
	{
		CP_Seconde = 0;
		T4CON &= ~(1<<2);   // TR4 = 0 -- Timer4 stoppé
		CP_Timer4 = T4;     // Lecture Compteur Timer4
		T4CON |= (1<<2);   // TR4 = 1 -- Timer4 redémarré
		// Fréquence = nbre total d'évènements par seconde
		frequence = ((CP_Overflow_Timer4) * (long)Event_to_Count) +
		            (int)(CP_Timer4 - OLD_CP_Timer4);
		printf("frequence : %d\n", frequence);
		OLD_CP_Timer4 = CP_Timer4;
		CP_Overflow_Timer4 = 0;
		
	}	
	// Gestion des évènements INT6 et INT7
		Event_to_Count = 1000; 

    }
	
	// Sécurité: si EXF2 est à 1 - RAZ de EXF2 	
	if (EXF2 == 1)
	{
		EXF2 = 0;
	}
	
	VISU_INT_TIMER2 = 0;
}	


//******************************************************************************
void Config_Timer4_Event_Counter(void)
{
	// Timer 4 configuré en compteur d'évènements SIG_IN
	// SIG_IN câblé sur l'entrée T4 du Timer4
	
	// Timer4 en mode autorechargement
	// Mode Counter
	// CLKTimer = SIG_IN
	// Valeur rechargement= (65536 - Nbre_Event_to_count)
	// L'overflow, et donc l'interruption Timer4 signale le comptage de 100 évènements
	T4CON = 0x02;   // Flags TF4 et EXF4 effacés
	                // RCLK1 et TCLK1 à zéro
	                // Transitions sur T4EX ignorées
	                // Timer stoppé
	                // Timer en mode counter
	                // Mode auto-reload
  RCAP4 = 65536-Event_to_Count;
  T4 = RCAP4;
  T4CON |= (1<<2);      // TR4 = 1 -- Timer2 démarré
  EIP2 |= (1<<2);      //PT4 = 0 -- Priorité Timer4 haute
  EIE2 |= (1<<2);      //ET4 = 1 --  INT Timer4 autorisée
}

//******************************************************************************
void ISR_Timer4 (void) interrupt 16
{
	
	
	VISU_INT_TIMER4 = 1; 
	
	if ((T4CON & (1<<7)) != 0)   // Test TF4 = 1
	{
		T4CON &= ~(1<<7);    // RAZ TF4
		SIG_OUT = !SIG_OUT;	  // Génération SIG_OUT
		// Prise en compte d'un comptage d'évènements configurable
		// La lecture de la config 10-100-1000-10000 est faite dans ISR_Timer2
    RCAP4 = 65536 - Event_to_Count;	//Reload compteur d'évènements
    // Comptage des overflows (pour compter au delà de 65536)		
		CP_Overflow_Timer4++;
	}
	
	// Sécurité si T4EX est à 1
	if ((T4CON & (1<<6)) != 0)   // Au cas où: Test EXF4 = 1
	{	T4CON &= ~(1<<6); } // RAZ EXF4			
	
	VISU_INT_TIMER4 = 0;
}	
