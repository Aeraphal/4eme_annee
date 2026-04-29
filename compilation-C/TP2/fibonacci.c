#include <stdio.h>

float suite_f(int n, float *p)
{
    // Création des pointeurs pour se déplacer dans le tableau 
    float *p_1 = p; // notre premier pointeur, le terme le moins loin dans le tableau
    float *p_2 = p+1;// l'adresse suivante dans le tableau
    float *p_3 = p_2+1; 
    //printf("%p et %p\n", p_1, p_2);// vérification de l'incrément du deuxième pointeur


    // on initialise les 2 permiers termes de notre tableau 
    *p_1 = 0; //U0
    *p_2 = 1; // U1

    for (int i=2; i<= n; i++) // on commence que à 2 on a initialisé nos 2 premières valeurs de tableau
    {   
        //printf("%f et %f et %f\n", *p_1, *p_2, *p_3);// vérification des valeurs pointées du tableau
        *p_3 = *p_1+*p_2; // on complete le tableau

        // On se déplace de 1 dans notre tableau
        p_1 +=1;
        p_2 +=1;
        p_3 += 1;
        //printf("%p et %p et %p\n", p_1, p_2, p_3);// vérification de l'incrément de l'adresse dans les pointeurs
        
    }
}

float afficher_tableau(int n, float *p)
{
    float *p_1 = p;

    for (int i=0; i<= n; i++) // on commence que à 2 on a initialisé nos 2 premières valeurs de tableau
    {   
        printf("le terme %i : %f\n", i, *p_1);// affichage des valeurs stockées dans le tableau
        p_1++;// on se déplace dans le tableau de 1 case

        
    }


}

int main(void)
{
    int n = 10;
    float termes[n];
    float *p = termes;// pointeur du debut du tableau 
    
    suite_f(n, termes);
    afficher_tableau(n, termes);
   
}