#include <stdio.h>
#include <stdlib.h>


int * crea_tab(void);
void chercher( int *tableau, int terme);
//char * crea_tab_phrases();
//void cherche_phrase(char *tab, int taille_max_phrase, int nb_phrases, char *phrase);
int compte( char *p);

//On définie la taille de notre futur tableau selon notre convenance, ici 100

int main(void)
{
    int *tableau = crea_tab();

    /*for(int i=0; i< taille; i++) // verification génération du tableau
    {
        printf("[%d]", *(tableau+i) );
    }*/
    
    //chercher(tableau, 77);

    char phrase[256] = "nope";

    char phrases[10][256]={ "Phrase 1",
                            "Phrase 2",
                            "Phrase 3",
                            "Phrase 4",
                            "Phrase 5",
                            "Phrase 6",
                            "Phrase 7",
                            "Phrase 8",
                            "Phrase 9",
                            "Phrase 10"};

    for(int i=0; i< 10; i++)
    {
        int a =0;
        //printf("%c %c", phrases[i][a], phrase[a] );
        while( phrases[i][a] == phrase[a] ) // si les 2 chaines se finissent au même indice on testes termes à termes ça vaut le coup de tester le reste
        {
            if(phrase[a]=='\0')
            {
                printf("La phrase est dans le tableau");
                return 0;
            }
            a++; // on teste le caractere suivant
        }
        
        if(phrases[i][a] != phrase[a])
        { printf("les phrases sont differentes");
         return 0;}  
    }
}


int * crea_tab(void)
{
    
    static int numbers[5];// On crée un tableau de la taille définie tout à l'heure

    
    for (int i=0; i< 5; i++ )// On remplie ce tableau de valeurs aléatoire entre 0 et 100
    {
        numbers[i] = rand()%100;// numbers[i] = *(numbers+i)
    }
    
    return numbers;// On retourne le tableau de 100 caractères
}

void chercher( int *tableau, int terme)
{
    for (int i=0; i< 5; i++)
    {
        if(*(tableau+i)== terme)
        {
            printf("\n Entier présent \n");
        }
    }
    printf("\n Entier absent \n");
}


int compte( char *p)
{
    int counter = 0;
    int tour = 0;

    while(tour == 0)
    {
        if (*p=='\0')// par convention  on a un \n à la fin d'une chaine de caractère
        {
            counter ++; // on incrémente la taille du tableau
            p +=1; // on incrémente notre pointeur
            //printf("contenu pointeur %p\n", p);
        }
        else 
        {
            tour = 2;// on sort du while
        }
    }
    return counter;
}
