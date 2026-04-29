#include "fichier.h"
#include <stdio.h>


int main()
{
    lire_fichier("test.txt");
    ecrire_fichier("test.txt", " bonjour 2", 8);
    //printf(" apres ecriture\n");
    lire_fichier("test.txt");
}