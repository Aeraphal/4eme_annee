#include "fichier.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>


void lire_fichier(char *chemin)
{ 
    char data[1000];

    int file= open(chemin, O_RDONLY);// on ouvre le fichier 
    int size = read(file, data, 1000);  // on récupère la taille du fichier, 
                                    //on le stock ele contenu dans le tableau data
    for(int i =0; i< size; i++)
    {
        printf("%c", data[i]);
    }

    close(file);
}

void ecrire_fichier(char *chemin, char *to_add, int len_to_add)
{
    int file = open(chemin, O_CREAT|O_WRONLY, S_IRUSR|S_IWUSR);
    int size = write(file, to_add, len_to_add);
    close(file);
}