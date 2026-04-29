#include <stdio.h>
#include <stdlib.h>


int * crea_tab(void);
int chercher( int *tableau, int terme);

//On définie la taille de notre futur tableau selon notre convenance, ici 100
# define taille 5

int main(void)
{
    int *tableau = crea_tab();

    /*for(int i=0; i< taille; i++) // verification génération du tableau
    {
        printf("[%d]", *(tableau+i) );
    }*/
    
    chercher(tableau, 77);
}


int * crea_tab(void)
{
    // On crée un tableau de la taille définie tout à l'heure
    static int numbers[taille];

    // On remplie ce tableau de valeurs aléatoire entre 0 et 100
    for (int i=0; i< taille; i++ )
    {
        numbers[i] = rand()%100;// numbers[i] = *(numbers+i)
    }
    // On retourne le tableau de 100 caractères
    return numbers;
}

int chercher( int *tableau, int terme)
{
    for (int i=0; i< taille; i++)
    {
        if(*(tableau+i)== terme)
        {
            printf("\n Entier présent \n");
            return 1;
        }
    }
    printf("\n Entier absent \n");
    return 0;
}
