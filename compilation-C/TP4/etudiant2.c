#include "fichier.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include "etudiant2.h"
#include <string.h>

typedef struct data
{
    char nom[256];
    char prenom[256];
    char adresse[256];
    char ville[256];
    float note_c;
    float note_sys;
}data;


char c;
/*----------------------------------------------------------------*/
void creat_eleves(data *p, int nb)
 {
    for (int i =0; i < nb; i++)// on crée 5 eleves
    {
        printf("Informations Eleve %i :\n ", (i+1));

        printf("Prénom %i :\n ", (i+1));        
        scanf("%s", (p+i)->prenom); 

        c = getchar();

        printf("Nom %i :\n ", (i+1));
        scanf("%s",  (p+i)->nom);

        c = getchar();

        printf("Adresse %i :\n ", (i+1));
        scanf("%s",  (p+i)->addresse);

        c = getchar();

        printf("Ville  %i :\n ", (i+1));
        scanf("%s", ((p+i)->ville)); 

        c = getchar();

        printf("Note en prog C %i :\n ", (i+1));
        scanf("%f", &((p+i)->prog_C)); 

      //  printf("%f\n", *((p+i)->prog_C));

        c = getchar();

        printf("Note en Système d'exploitation %i :\n ", (i+1));
        scanf("%f", &((p+i)->sys_exp)); 

        c = getchar();
    }
 }
/*----------------------------------------------------------------*/

/*----------------------------------------------------------------*/
 void disp_eleves(data *p, int nb)
 {

    for (int i =0; i < nb; i++)// on crée 5 eleves
    {
        printf(" Elève %i ", i+1);
        printf("Prenom eleve :  %s  \n ", (p+i)->prenom);
        
        printf("Nom eleve :  %s\n ", (p+i)->nom);

        printf("Adresse eleve : %s \n ", (p+i)->addresse);

        printf("Note prog_c eleve : %f\n ", (p+i)->prog_C);
     
        printf("Note sys_exp eleve  : %f\n ", (p+i)->sys_exp);
        
    }
 }
/*----------------------------------------------------------------*/

void save_eleve(data *tableau, char *chemin, int nb)
{
    int size;
    int file = open(chemin, O_CREAT|O_WRONLY, S_IRUSR|S_IWUSR);
    
    for(int i=0; i< nb; i++)
    {
        char note_1= (char)(tableau+i)->prog_C ;
        char note_2= (char)(tableau+i)->sys_exp; 

        write(file, &( (tableau+i)->nom), 20 );
        write(file, &( (tableau+i)->prenom), 20);
        write(file, &( (tableau+i)->addresse), 20);
        write(file, &note_1, 5);
        write(file, &note_2, 5);
       

    }
    close(file);

}

/*----------------------------------------------------------------*/
void save_eleve_2(data *tableau, char *chemin, int nb_eleves)
{
    FILE *fichier = fopen(*chemin, "w+"); //on initialise le pointeur de notre fichier

    for(int i=0; i< nb; i++)
    {
        char note_1= (char)(tableau+i)->prog_C ;
        char note_2= (char)(tableau+i)->sys_exp; 
        fprints(fichier," %s, %s, %s, %s, %d, %d", *(tableau+i)->nom, *(tableau+i)->prenom, *(tableau+i)->addresse, *(tableau+i)->ville, *(tableau+i)->prog_C, *(tableau+i)->sys_exp) // on ecrit du texte formaté
    }
    fclose(fichier);

}
