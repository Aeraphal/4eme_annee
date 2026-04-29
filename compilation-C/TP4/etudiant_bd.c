#include "fichier.h"
#include <stdio.h>
#include "etudiant2.h"

void save_eleve_2(data *tableau, char *chemin, int nb_eleves);
void save_eleve(data *tableau, char *chemin, int nb);

void main()
{
    data eleves[5]; //on crée un tableau de 5 eleves avec toute les infos
    creat_eleves(eleves, 2);
    //disp_eleves(eleves, 2);
    save_eleve_2(eleves, "eleves.txt", 5);
    
    lire_fichier("eleves.txt");

}