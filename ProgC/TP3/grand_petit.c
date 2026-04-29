#include <stdio.h>
#include <stdlib.h>

//On définie la taille de notre futur tableau selon notre convenance, ici 100
# define taille 100

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

    // La fonction pour trouver le plus grand paramètre dans le tableau
int grand( int *p)
{   
    // La première variable est le premier élément du tableau
    int p_grand = *p;
    // On voyage à travers tout le tableau et on compare un à un les éléments
    for(int i=0; i< taille; i++)
    {
        if (p_grand < *(p+i))
        {
            p_grand = *(p+i);
        }
    }
    return p_grand;
}

    // On fait la même chose pour trouver l'élément le plus petit
int petit( int *p)
{   
    int p_petit = *p;

    for(int i=0; i< taille; i++)
    {
        if (p_petit > *(p+i))
        {
            p_petit = *(p+i);
        }
    }

    return p_petit;
}

int main (void)
{
    // On appelle la fonction pour creér le tableau
    int *tableau = crea_tab();

    for (int i=0; i <taille; i++)
    {
        printf("[%d]", *(tableau+i) );
    }

    // On appelle les fonctions pour trouver le plus grand et le plus petit élément du tableau
    printf("\nle + grand : %i\n", grand(tableau));
    printf("le + petit : %d\n", petit(tableau));


}
