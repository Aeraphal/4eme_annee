#include <stdio.h>

int main()
{
    /* avec les puissances de 2 */
    /*int variable= 250 ;
    int init_variable = variable;
    int compteur = 0;
    int iarray[64];
    //initialisation du tableau à 0
    for (int a = 0; a <= 64; a++)
    {
        iarray[a] = 0;
    }

    // calcul du nombre ne binaire
    do
    {
        // on stocke les valeurs binaires vers la fin du tableau
        if (variable%2 == 1)
        {
            iarray[64-compteur] = 1;
        }
        else
        {
            iarray[64-compteur] = 0;
        }
        variable = variable/2;
        compteur++;

    } while(variable >= 1 );
    
    printf("Le nombre binaire de %d est ", init_variable);

    // recuperation de notre chiffre en binaire pour affichage dans l'ordre
    for (int b = 64 - compteur+1; b <= 64; b++)
    {
        printf("%d", iarray[b]);
    }


    printf("\n\n");*/
    

    /* Avec un mask */
    int variable= 25 ;
    int init_variable = variable;
    long long int mask = 1;
    int compteur = 0;
    int iarray[64];

    //initialisation du tableau à 0
    for (int a = 0; a <= 64; a++)
    {
        iarray[a] = 0;
    }

    // calcul du nombre ne binaire
    do
    {
        // on applique le mask a notre valeur
        iarray[64-compteur]= mask & variable;

        //Evolution des variables
        printf("%lld\n", mask & variable);
        printf("%d\n", variable);
        // on décale notre variable à droite afin d'atteindre et comparer le bit de poids fort
        variable = variable >> 1;

        // on incrémente le nb de valeurs stockées dans le tableau pour les retrouver après
        compteur ++;
    } while(variable >= mask );
    
    printf("Le nombre binaire de %d est ", init_variable);

    // recuperation de notre chiffre en binaire pour affichage dans l'ordre
    for (int b = 64 - compteur+1; b <= 64; b++)
    {
        printf("%d", iarray[b]);
    }


    printf("\n\n");


    return 0;
}