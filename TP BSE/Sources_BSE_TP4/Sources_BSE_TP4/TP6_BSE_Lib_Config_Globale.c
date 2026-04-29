#include "C8051F020.h"
#include "c8051F020_SFR16.h"
#include "TP6_BSE_Lib_Config_Globale.h"

// Peripheral specific initialization functions,
// Called from the Init_Device() function

//-----------------------------------------------------------------------------
// Dévalidation du watchdog
//-----------------------------------------------------------------------------
void Reset_Sources_Init()
{
	// La configuration des registres WDTCN  sera étudiée plus tard
	 WDTCN = 0xDE;
	 WDTCN = 0XAD;
}

//-----------------------------------------------------------------------------
// Configuration des Ports d'entrée-sorties
//-----------------------------------------------------------------------------

void Port_IO_Init()
{
    // P0.0  -  TX0 (UART0)
    // P0.1  -  RX0 (UART0)
    // P0.2  -  INT0 (Tmr0)
    // P0.3  -  INT1 (Tmr1)
    // P0.4  -  T2 (Timer2)
    // P0.5  -  T2EX (Tmr2)
    // P0.6  -  T4 (Timer4)
    // P0.7  -  T4EX (Tmr4)
    // P1.0  -  SYSCLK

    // P1.2  to P7.7 - Mode GPIO par défaut 
 
    XBR0      = 0x04; 
    XBR1      = 0xF4; 
    XBR2      = 0x58; 

// Config pour LED
	  P1MDOUT |= (1<<6);  // P1.6  en Push Pull
// Config pour gestion bouton poussoir
	     P3 |= (1<<7); // Mise à 1 de P3.7
       P3MDOUT &= ~(1<<7); // P3.7 en Drain ouvert
// Config pour drapeaux matériels d'interruption	
// drapeau INT7 P2.4
        P2MDOUT |= (1<<4);  // P2.4 en Push Pull
				P2 &= ~(1<<4);       // P2.4 mis à zéro
// drapeau INT6 P6.4				
	      P74OUT |= (1<<5);   // P6.4 à P6.7 en PP	     
        P6 &= ~(1<<4); 	     // P6.4 mis à zéro
// drapeau INT Timer2  P3.5				
	      P3MDOUT |= (1<<5);  // P3.5 en Push Pull
	      P3 &= ~(1<<5);       // 3.5 mis à zéro
// drapeau INT Timer4  P3.4
        P3MDOUT |= (1<<4);  // P3.4 en Push Pull
	      P3 &= ~(1<<4);       // 3.4 mis à zéro
// Config sortie SYSCLK
	      P1MDOUT |= (1<<0);  // P1.0 en PP pour SYSCLOCK
// Gestion SIG_OUT  P3.3
	   P3MDOUT |= (1<<3);  // P3.3 en Push Pull
	   P3 &= ~(1<<3);       // 3.3 mis à zéro
//Config  P2.5 et P2.5 entrée config comptage d'évènements
	   P2MDOUT &= ~((1<<5)|(1<<6)); // P2.5 et P2.6 ou OpenDrain
	   P2 |= ((1<<5)|(1<<6)); // P2.5 et P2.6 en entrée
// Config T4 - P0.6
     P0MDOUT &= ~(1<<6);  // P0.6 en Open Drain
	   P0 |= (1<<6);       // 0.6 mis à un

}
//******************************************************************************
// Config oscillateur pour étape2
void Oscillator_Init_Osc_Quartz(void)
{
    int i = 0;
    OSCXCN    = 0x67;
    for (i = 0; i < 3000; i++);  // Wait 1ms for initialization
    while ((OSCXCN & 0x80) == 0);
    OSCICN    = 0x08;
}


//-----------------------------------------------------------------------------
// Initialisation globale du Microcontrôleur - 
//-----------------------------------------------------------------------------
void Init_Device(void)
{
    Reset_Sources_Init();
    Port_IO_Init();
	  Oscillator_Init_Osc_Quartz();
}



