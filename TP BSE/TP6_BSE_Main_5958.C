//-----------------------------------------------------------------------------
// TP6_BSE_Main.c
// AUTH: FJ
// DATE: 12/12/2022
// Target: C8051F02x
// Tool chain: KEIL Microvision5
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

// CETTE APPLICATION REALISE LES TACHES SUIVANTES:
//
// - Clignotement de la LED P1.6
//     Commande du rapport cyclique du clignotement de la LED
//     avec le bouton poussoir P3.7 via l'interruption INT7
//     A chaque appui le rapport cyclique allumé/éteint change
//
//  - Conversion A/N sur les voies AIN0.3 et/ou AIN0.7 pour des signaux d'entrée (0-1V)
//    la cadence de 10KHz et restitution sur la sortie DAC0 (0-2V)
//    La sélection de la voie à convertir est assurée via la liaison série (Terminal PUTTY)
//    Saisir "3" pour convertir AIN0.3 (voie 3 de l'ADC0)
//    Saisir "7" pour convertir AIN0.7, (voie 7 de l'ADC0)
//    Saisir "mux" pour convertir en alternance AIN0.3 et AIN0.7, 
//    Par défaut, cest la voie 7 qui est envoyée sur le DAC0

//  CONFIGURATIONS DES DIVERS PERIPHERIQUES:
//
// SYSCLK = Quartz externe = 22.1184 MHz (Visu sur P1.0)
// Mise en oeuvre de la base de temps Timer2 de 10ms et interruption Timer2
// Mise en oeuvre de la base de temps Timer3 de 100Us et déclenchement conversion ADC0
// Mise en oeuvre de l'UART0 à 115200 Bd, pas de parité, 8 bits, 1 stop bit 

// Visu Flag INT7 sur P2.4
// Visu Flag INT Timer2 sur P3.5
// Visu Flag INT ADC0 sur P3.4
//
// POINTS CLES A VERIFIER
//  1 -   Clignotement de la LED P1.6 et réglage du ratio Allumage/extinction selon action
//        sur le bouton poussoir P3.7
//  2 -   La période de la base de temps Timer2 est de 10 milliseconde (à 1% près)
//  3 -   La fréquence de conversion A/N est de 10KHz (à 1% près)
//  4 -   La voie convertie par défaut est la voie 7 (AIN0.7)
//  5 -   La conversion A/D suivie de la conversion D/A produit bien un gain en tension de 2
//  6 -   Via le terminal de commande Putty, on parvient bien à commuter les voies 
//        3, 7 ou alternées (mode mux)
//*****************************************************************************
//-----------------------------------------------------------------------------
// Fichiers d'entête
#include "intrins.h"
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
#include<c8051F020.h>
#include<c8051F020_SFR16.h>

void Config_Timer2_TimeBase(void);
void Init_Device (void);
void Reset_Sources_Init();
void Port_IO_Init();
void Oscillator_Init_Osc_Quartz();
void CFG_Clock_UART0(void);
void CFG_UART0(void);
char putchar(char c);
char _getkey(void);
char getkey_one_time(void);
void Config_INT7(void);
void  Voltage_Reference_Init(void);
void  ADC0_Init(void);
void  DAC0_Init(void);
void  Timer3_Init_Fech(void);
//-----------------------------------------------------------------------------
// Déclaration des MACROS

#define LED_ON 1
#define LED_OFF 0
#define LED_BLINK 0
#define PERIOD_LED_MAX 20
#define INCREMENT_PERIOD_LED 4

#define TO_BE_PROCESSED 1
#define PROCESSED 0

#define MODE_MUX 0
#define MODE_VOIE3 1
#define MODE_VOIE7 2

//-----------------------------------------------------------------------------
// Déclarations Registres et Bits de l'espace SFR
sbit LED = P1^6;  // LED
sbit BP =P3^7;
sbit VISU_INT7 = P2^4;
sbit VISU_INT_ADC0 = P3^4;
sbit VISU_INT_TIMER2 = P3^5;

//-----------------------------------------------------------------------------
// Variables globales

bit Event = PROCESSED;  // Détection des évènements pour changer le clignotement de la LED
bit 	Flag_Seconde = 0; // drapeau 1s écoulée
unsigned char Mode = MODE_VOIE7;

//-----------------------------------------------------------------------------
// MAIN Routine
//-----------------------------------------------------------------------------
void main (void) {
	
const char code Mode_Mux[] = "MODE_MUX";
const char code Mode_Voie7[] = "MODE_Voie7";
const char code Mode_Voie3[] = "MODE_Voie3";	
const char code Mode_Voie7_Default[] = "MODE_Voie7_Default";
  	
char  buf[20];
char i;
int value;	

char *ptr_Mode;	
char *ptr_char;	

	
 	   // Configurations globales
	      Init_Device(); 
	   // Configurations  spécifiques  
	      Config_INT7(); // Configuration de INT7
	      Config_Timer2_TimeBase();
	      CFG_Clock_UART0();
	      CFG_UART0();
	      Voltage_Reference_Init();
        ADC0_Init();	
	      DAC0_Init();
				Timer3_Init_Fech();
// Fin des configurations	

	      printf("**** TP6 - System OK ****\n\r");
	      printf("Attente Frappe Clavier...\n\r"); 
	      ptr_Mode = Mode_Voie7;
				
				EA = 1;  // Validation globale des interruptions
				
// Boucle infinie	
         while(1)
         { 
             while(getkey_one_time()==0);  // Attente de la réception d'un caractère
						 
              printf(" Choix Voie : ");
							gets(buf,sizeof(buf)-1);
							for(i=0;i<sizeof(buf);i++)
						  { buf[0] = tolower(buf[0]); } 
              ptr_char = strstr(buf,"mux");
							if (ptr_char !=0) 
							{	  
								 Mode = MODE_MUX;
								 ptr_Mode = Mode_Mux;
							}  								
							else 
							{	
								value = atoi(buf);
							  if (value==3) 
								{	
									 Mode = MODE_VOIE3;
									 ptr_Mode = Mode_Voie3;
								}	
								else if (value==7) 
								{	
									 Mode = MODE_VOIE7;
									 ptr_Mode = Mode_Voie7;
								}	
                else
								{
									 Mode = MODE_VOIE7;
									 ptr_Mode = Mode_Voie7_Default;
								}									
							} 							
							 printf(" \r Mode retenu: %s \n\r",ptr_Mode);	 							
				}				               	
}
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
// FONCTIONS D'INTERRUPTION
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------

//******************************************************************************
// Interruption ADC0
//******************************************************************************
void ISR_ADC0 (void) interrupt  15
{
	VISU_INT_ADC0 = 1; 
	if (AD0WINT == 1)   // Fin de conversion suite à overflow timer 3
	 { 
		 AD0WINT = 0;
		 DAC0L = ADC0L;  // Renvoi de la donnée acquise sur DAC0
		 DAC0H = ADC0H;
		 switch (Mode)
		{ 
			 case 0:   // MODE_MUX
			   AMX0SL ^= (1<<2); //Commutation voie3 <--> voie 7
			   break;
			 case 1: //  MODE VOIE 3
				  AMX0SL = 0x03;  // Commutation voie 3
			    break;
			  case 2:  //MODE VOIE 7
				  AMX0SL = 0x07;  // Commutation voie 7
			    break;
				default: 
				 AMX0SL = 0x07;  // Commutation voie 7
			    break;	
     }			 
   }		 
	 if (AD0INT == 1)  // Au cas où...
	 { 
		 AD0INT = 0;
   }		
  VISU_INT_ADC0 = 0; 	 
}
//******************************************************************************
// Interruption INT7
//******************************************************************************
////******************************************************************************
//// Detection d'une action sur le Bouton poussoir P3.7
////******************************************************************************
void ISR_INT7 (void) interrupt 19  // Interruption Bouton poussoir
{
	VISU_INT7 = 1;
	P3IF &= ~(1<<7); // IE3 mis à 0 - remise à zéro du pending flag de INT7 effacé
	Event = TO_BE_PROCESSED;
	VISU_INT7 = 0;
}
//******************************************************************************
// Interruption Timer2
//******************************************************************************
//******************************************************************************
//  Base de temps de 10ms
// Gestion du clignotement de la LED
// Prise en compte du changement de mode de clignotement 
//*******************************************************************************
void ISR_Timer2 (void) interrupt 5
{
	static char CP_Cligno;
	static char CP_Seconde = 0;
	static unsigned int CP_LED_ON = PERIOD_LED_MAX/2;

	VISU_INT_TIMER2 = 1;
	
	if (TF2 == 1)
	{
		TF2 = 0;
	  CP_Seconde++;
	  if (CP_Seconde >= 100) 
	  {
		  CP_Seconde = 0;
		  Flag_Seconde = 1;
	  }	
	// Gestion des évènements INT6 et INT7
	// pour gérer les modes de clignotement de la LED
		if (Event == TO_BE_PROCESSED)
						 {
							 Event = PROCESSED;
							 CP_LED_ON += INCREMENT_PERIOD_LED;
							 if (CP_LED_ON > PERIOD_LED_MAX) CP_LED_ON = 0;
							 //STATE_LED =  !STATE_LED;
							 
						 }
	// Gestion du mode de clignotement de la LED					 
    CP_Cligno++;
	  if (CP_Cligno > PERIOD_LED_MAX) CP_Cligno = 0;
    if (CP_Cligno < CP_LED_ON) LED = LED_ON;
		else LED = LED_OFF;
	}
	// Sécurité: si EXF2 est à 1 - RAZ de EXF2 	
	if (EXF2 == 1)
	{
		EXF2 = 0;
	}
	VISU_INT_TIMER2 = 0;
}	
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
// FONCTIONS DIVERSES
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------

//*****************************************************************************	 
//  Reset_Sources_Init
//  Dévalidation du watchdog
//*****************************************************************************	 
void Reset_Sources_Init()
{
	// La configuration des registres WDTCN  sera étudiée plus tard
	 WDTCN = 0xDE;
	 WDTCN = 0XAD;
}
//*****************************************************************************	 
//  Port_IO_Init
// Configuration des Ports d'entrée-sorties
//*****************************************************************************	 
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
// Config pour TX0 de UART0 - P0.0
	  P0MDOUT |= (1<<0);  // P0.0  en Push Pull
// Config pour LED
	  P1MDOUT |= (1<<6);  // P1.6  en Push Pull
// Config pour gestion bouton poussoir
	     P3 |= (1<<7); // Mise à 1 de P3.7
       P3MDOUT &= ~(1<<7); // P3.7 en Drain ouvert
// Config pour drapeaux matériels d'interruption	
// drapeau INT7 P2.4
        P2MDOUT |= (1<<4);  // P2.4 en Push Pull
				P2 &= ~(1<<4);       // P2.4 mis à zéro
// drapeau INT Timer2  P3.5				
	      P3MDOUT |= (1<<5);  // P3.5 en Push Pull
	      P3 &= ~(1<<5);       // 3.5 mis à zéro
// Config sortie SYSCLK
	      P1MDOUT |= (1<<0);  // P1.0 en PP pour SYSCLOCK
// drapeau INT ADC0  P3.4		VISU_INT_ADC0	
	      P3MDOUT |= (1<<4);  // P3.4 en Push Pull
	      P3 &= ~(1<<4);       // 3.4 mis à zéro
}
//*****************************************************************************	 
//  Oscillator_Init_Osc_Quartz
//*****************************************************************************	 
void Oscillator_Init_Osc_Quartz(void)
{
    int i = 0;
    OSCXCN    = 0x67;
    for (i = 0; i < 3000; i++);  // Wait 1ms for initialization
    while ((OSCXCN & 0x80) == 0);
    OSCICN    = 0x08;
}
//*****************************************************************************	 
//  Init_Device
//  Initialisation globale du Microcontrôleur
//*****************************************************************************	 
void Init_Device(void)
{
    Reset_Sources_Init();
    Port_IO_Init();
	  Oscillator_Init_Osc_Quartz();
}
//*****************************************************************************	 
//  Config_Timer2_TimeBase
//	Configuration du Timer2 en Base de temps
//*****************************************************************************	 
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
 	RCAP2H = 0xB8;
	RCAP2L = 0x00;
  T2 = RCAP2;
  TR2 = 1;                 // Timer2 démarré
  PT2 = 1;							  // Priorité Timer2 Haute
  ET2 = 1;							  // INT Timer2 autorisée
}
//*****************************************************************************	 
//  CFG_clock_UART
//	Utilisation du Timer 1
//*****************************************************************************	 
void CFG_Clock_UART0(void)
{
    CKCON |= (1<<4);             // T1M: Timer 1 Clock Select
	                               // Timer CLK = SYSCLK
	
    TMOD |= (1<<5);             
	  TMOD &= ~((1<<7)|(1<<6)|(1<<4));			  // Timer1 configuré en Timer 8 bit 
	                                          // avec auto-reload	
	  TF1 = 0;				  // Flag Timer effacé
    TH1 = 0xF4;;
	  ET1 = 0;				   // Interruption Timer 1 dévalidée
	  TR1 = 1;				   // Timer1 démarré
}

//*****************************************************************************	 
//  CFG_uart0_mode1
//*****************************************************************************	 
void CFG_UART0(void)
{
		RCLK0 = 0;   // Source clock Timer 1
		TCLK0 = 0;
		PCON  |= (1<<7); //SMOD0: UART0 Baud Rate Doubler Disabled.
		PCON &= ~(1<<6); // SSTAT0=0
		SCON0 = 0x70;   // Mode 1 - Check Stop bit - Reception validée
		               
 //   TI0 = 0;     // Drapeaux TI et RI à zéro
    RI0 = 0;	
	  TI0 = 1;  //à cause du codage de putchar
	
	  ES0 = 0;  // Interruption UART non autorisée
}
//*****************************************************************************	 
//  putchar
//*****************************************************************************	 
char putchar(char c)
{
	while(TI0==0);
	TI0 = 0;
	SBUF0 = c;
	return c;
}

//*****************************************************************************	 
//  _getkey
//*****************************************************************************	  
char _getkey(void)
{
  char c;
	while(RI0==0);
	RI0 = 0;
	c = SBUF0;
	return c;
	
}
//*****************************************************************************	 
//  getkey_one_time
//*****************************************************************************	  
char getkey_one_time(void)
	
{
	if (RI0==0) return 0;
	else
  {
	   RI0 = 0;
	   return SBUF0;
	}
}
//*****************************************************************************	 
//  Config_INT7
//*****************************************************************************	  
void Config_INT7(void)
{
	P3IF &= ~(1<<7); // IE7 mis à 0 pending flag de INT7 effacé
	P3IF &= ~(1<<3); // IE7CF mis à 0 - sensibilité int7 front descendant	
	
	EIP2 &= ~(1<<5);  // PX7 mis à 0 - INT7 priorité basse
	EIE2 |= (1<<5);  // EX7 mis à 1 - INT7 autorisée
}
//******************************************************************************
// Voltage_Reference_Init
//******************************************************************************
void  Voltage_Reference_Init(void)
{
	 REF0CN    = 0x03; // ADC0 voltage reference from VREF0 pin
	                   // ADC1 voltage reference from VREF1 pin
	                   // Internal Temperature sensor off
	                   // Internal bias generator ON
	                   // Internal Referece Buffer On
}
//******************************************************************************
// ADC0_Init
//******************************************************************************
void  ADC0_Init(void)
{
		AMX0CF = 0;  // Toutes les voies sont en unipolaire
	  AMX0SL = 0x07; // Sléction voie AIN7
	  ADC0CF    = 0x51; // AD0SC = 10 --> CLKsar = 2,01MHz
	                    // Gain =2
	  // Config ADC0CN
	  AD0TM = 1; // Tracking durant 3 SAR Clk après mise à 1 de AD0BUSY
	  AD0INT = 1;  // RAZ flag interruption INT0
	  AD0CM0 = 1;
	  AD0CM1 = 0; // Conversion ADC déclenchée par overflow Timer3
	  AD0WINT = 0; // RAZ Flag ADC0 Windows compare
    AD0LJST = 0; // justification à droite du résultat de la conversion
	               // config terminée
	   EIE2  |= (1<<1);  // EADC0 Enabled - INT ADC0 autorisée
	   EIP2  &= ~(1<<1); // Priorité INT ADC0 basse
	
	  AD0EN = 1;   // ADC0 démarré
}
//******************************************************************************
// DAC0_Init
//******************************************************************************
void  DAC0_Init(void)
{
	DAC0CN &= ~((1<<4)|(1<<3));  // DAC output updates on a write to DAC0H 
	DAC0CN &= ~((1<<2)|(1<<1)|(1<<0));  // Valeur 12 bits calée à droite 
	DAC0CN |= (1<<7);       // DAC0EN =1  -- DAC Enabled
}
//******************************************************************************
// Timer3_Init
//******************************************************************************
void  Timer3_Init_Fech(void)
{
	//TMR3RL = -(SYSCLK/10000);  // Pour générer Fech à 10Khz
	TMR3RL = 0xF75D;
	TMR3CN = 0x06;  // Flag Timer effacé
	                // Timer 3 démarré
	                // CLKTimer3 = Sysclk
	                // CLKTimer = source interne
}
