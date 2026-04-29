#include <stdio.h>

float puissance( float val, int puiss)
{
    // on sauvegarde la valaur initiale a pour le calcul des puissances
    float c = val;
    // on utilise un pointeur comme ça on a pas a retourner de valeur, ça fait tt tranquillou
    float *p = &val; // on met l'adresse de la variable a dans le pointeur

    // calcul de la puissance
    for (int i=1; i < puiss; i++)
    {
        //printf("\na : %f\n",val);
        // on multiplit par la valeur d'origine
        (*p)*=c;// on multiplit par c l'interieur de la variable à l'adresse du pointeur, soit la variable pointée
    }
    return *p;
}

int main (void)
{
    float a = 9;
    int b = 3;
    printf("%f puissance %d égal : ", a, b);
    
    printf("%f\n",puissance(a,b));

}