#include <stdio.h>
#include <stdlib.h>


// déclaration des prototypes
void tab_entier( int *tableau, int len_tab, int max, int min);
void traitement(int *tab_1, int len_1);
void tab_float( float *tableau, int len_tab, int max, int min);
void disp_tab_int(int *tableau, int len, char titre);
void disp_tab_float(float *tableau, int len, char titre);

# define len_tab_int 10
# define len_tab_float 10

int main(void)
{
    int tab_1[len_tab_int]; // déclaration du tableau de 10 cases d'entiers
    float tab_2[len_tab_float];// déclaration du tableau de 10 cases de floats

    // remplissage tableau des entiers 
    tab_entier(tab_1, len_tab_int, 100, 0);
    disp_tab_int(tab_1, len_tab_int,"tableau des entiers"); // affichage du tableau remplit
    traitement(tab_1); // ce qi nous est demandé de l'exercice
    disp_tab_int(tab_1, len_tab_int, "tableau des entiers"); // affichage du tableau altéré

    // remplissage tableau des floats
    tab_float( tab_2, len_tab_float, 100.0, 0.0);
    disp_tab_int(tab_2, len_tab_float, "tableau des floats"); // affichage du tableau remplit
    traitement(tab_2); // ce qi nous est demandé de l'exercice
    disp_tab_int(tab_2, len_tab_float, "tableau des floats"); // affichage du tableau altéré
}




void tab_entier( int *tableau, int len_tab, int max, int min)
{
    /* fonction qui remplit unb tableau d'entiers avec des valuers aléatoires entre 0 et la limite en paramètre
        int * tableau : l'adresse de la première case du tableau 
        int len_tab : la taille du tableau 
        int max : la valeur max qu'une des valeurs du tableau peut recevoir
        int min : la valeur min qu'une des valeurs du tableau peut recevoir
    */
    for(int i=0; i < len_tab; i++)
    {
        *(tableau +i) = min + (rand() % (max-min)); //génération du nombre aléatoire dans l'interval renseigné
    }

}

void tab_float( float *tableau, int len_tab, int max, int min)
{
    /* fonction qui remplit unb tableau de float avec des valuers aléatoires entre 0 et la limite en paramètre
        int * tableau : l'adresse de la première case du tableau 
        int len_tab : la taille du tableau 
        int max : la valeur max qu'une des valeurs du tableau peut recevoir
        int min : la valeur min qu'une des valeurs du tableau peut recevoir
    */
    for(int i=0; i < len_tab; i++)
    {
        *(tableau +i ) = min + (rand() % (max-min)); //génération partie entière du nombre
        *(tableau +i ) += rand() % 1; //génération d'après la virgule

    }

}

void traitement(int *tab, int len)
{
    /* tâche demandée dans l'exercice, multiplier par 3 les valeurs dont les indices sont des multiples de 2
        int *tab: adresse première case du tableau 
        int len : taille du tableau mis en paremètres
    */
    for (int i=0; i< len; i++)
    {
        if( (i%2) == 0)
        {
            *(tab+i) *=3; // si l'indice est un multiple de 2 on multiplit le contenu de la memoire de cette case par 3
        }
    }
}

void disp_tab_int(int *tableau, int len, char titre)
{
    /* Cette fonction permet d'afficher un tableau d'entiers avec en première ligne le titre, puis  après un passage à la ligne les valeurs du tableau
        int *tableau : adresse de la première ca se du tableau 
        int len : la taille du tableau passée en paramètres
        char titre : la titre qque l'on veut afficher sur la ligne au dessus des valeurs du tableau
    */
    printf( " \n %c \n", titre )
    for(int i=0; i< len; i++)
    {
        printf(" %i ", *(tableau+i));
    }
}

void disp_tab_float(float *tableau, int len, char titre)
{
    /* Cette fonction permet d'afficher un tableau d'entiers avec en première ligne le titre, puis  après un passage à la ligne les valeurs du tableau
        float *tableau : adresse de la première ca se du tableau 
        int len : la taille du tableau passée en paramètres
        char titre : la titre qque l'on veut afficher sur la ligne au dessus des valeurs du tableau
    */
    printf( " \n %c \n", titre )
    for(int i=0; i< len; i++)
    {
        printf(" %f ", *(tableau+i));
    }
}
