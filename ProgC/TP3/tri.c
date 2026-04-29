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

int tri( int *p)
{   

    // On utilise une double boucle for pour comparer chaque termes avec tous les autres
    for(int i=0; i< taille; i++)
    {
        for(int a = 0; a< taille; a++)
        {
            if (*(p+i)<*(p+a) )
            {
                // On permute les termes, on place le plus petit à gauche et le plus grand à droite afin d'ériger un tableau trier en ordre croissant
                int tempo = *(p+i);
                *(p+i) = *(p+a);
                *(p+a) = tempo;
            }
        }
    }

}

int main(void)
{
    int *tableau = crea_tab();
    /*for(int i=0; i< taille; i++)
    {
        printf("[%d]", *(tableau+i) );
    }*/

    tri(tableau);

    for(int i=0; i< taille; i++)
    {
        printf("[%d]", *(tableau+i) );
    }

}