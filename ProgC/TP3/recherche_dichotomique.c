#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//On définie la taille de notre futur tableau selon notre convenance, ici 100
#define taille 100
#define taille_int 4

int * crea_tab(void)
{
    // On crée un tableau de la taille définie tout à l'heure
    static int numbers[taille];

    // On remplie ce tableau de valeurs aléatoire entre 0 et 100
    for (int i=0; i< taille; i++ )
    {
        numbers[i] = rand()%1000;// numbers[i] = *(numbers+i)
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

int dichotomie( int *tableau, int terme)
{
    int *max = tableau + taille;
    int *min = tableau;
    int counter = 2;
    int *ind_pivot = tableau + (((taille/counter))); // on stocke dans une variable l'adresse du pivot
    int taille2 = taille;
    int sens = 0; // aide au déplacement du pivot 
    int conte = 1;

    while (*max !=*min && conte < taille)
    {
        if(*ind_pivot > terme)
        {
            *max = *ind_pivot;
            sens = -1; // déplacement du pivot vers la gauche
            
        }
        else
        {
            *min = *ind_pivot;
            sens = 1;// déplacement du pivot vers la droite
        }
    
        taille2 = (int) taille2/counter;
        counter *=2;
        ind_pivot += sens*(taille/counter);
        conte += 1;
    }


    // On regarde si on a la valeur dans notre liste ou non

    if (*ind_pivot == terme)
    {
        printf("Entier trouvé\n");
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
    printf("\n\n");
    dichotomie(tableau, 12);
}