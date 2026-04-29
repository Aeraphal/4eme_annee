#include <stdio.h>
#include <stdlib.h>

// les prototypes pour les fonctions
char compte(char *p);
char incruste(char *tab_1, char*tab_2);
char copie(char *tab_1, char *tab_2);


int main(void)
{

    char chaine_1[]= "bonjour_1";
    char chaine_2[]= "bonjour_2";
    int taille = compte (chaine);
    int ch_concatene = concatenation(chaine_1, chaine_2);

}

/* -------------------------------------------------------------------------*/
char compte(char *p)
{
    int counter = 0;
    int tour = 0;

    while(tour == 0)
    {
        if (*p!='\0')// par convention  on a un \n à la fin d'une chaine de caractère, tant que l'on tombe pas dessus on continu de compter
        {
            counter ++; // on incrémente la taille du tableau
            p +=1; // on incrémente notre pointeur
            printf("contenu pointeur %p\n", p);
        }
        else 
        {
            tour = 2;// on sort du while
        }
    }
    printf("talle %i\n", counter);
    return counter;
}
/* -------------------------------------------------------------------------*/
 char copie(char *tab_1, char *tab_2)
 {
    int n1 = (compte(tab_1) - 1) ;
    int n2 = compte(tab_2);// combien de termes on doit ajouter à la chaîne 
    
    tab_1 = (char *) realloc (tab_1, n*sizeof(char));// on agrandit la chaîne de caractere qui va recevoir la partie copiée
    
    *(tab_1+n1) = ' ';// on met un espace entre les 2 chaînes

    // on copie dans la chaîne
    for (int i= 0 ; i < n2; i++)
    {
        *(tab_1 + n1 + 1 +i)= *(tab_2 + i);
    }

 }
/* -------------------------------------------------------------------------*/
char concatenation(char *tab_1, char*tab_2)
{
    
    // on définit la taille des chaînes de caracteres à concaténer 
    int n1 = compte(tab_1);
    int n2 = compte(tab_2);
    static char result_tab[n1+n2];

    for (int i=0; i< n1+n2 ; i++) // on parcours des indices de la chaine qui se fait envahir
    {
        if (i < (n1-1) ) // on place la premiere chaîne de caractere dans la chaîne finale
        {
            *(result+i) = *(tab_1+i); // result[i] = tab_1[i]
        }
        else if (i >= n1)// on ne veut pas stocker le \0 de la fin de la premiere chaîne de cractères
        {
            int i_2 = i-n1+1;
            *(result+i) = *(tab_2+i); 
        }
        else( i == n1-1)// il faut insérer un espace entre les deux chaînes concaténées
        {
            *(result+i) = ' '; 
        }
    }

    //on efface les 2 chaînes de caracteres car elles ont été concaténées
    //delete [] tab_1;
    //delete [] tab_2;

    return result_tab;

}