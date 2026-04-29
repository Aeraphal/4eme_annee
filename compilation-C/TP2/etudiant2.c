#include <stdio.h>

typedef struct data 
{
    char prenom[256];
    char nom[256];
    char addresse[256];
    float prog_C;
    float sys_exp;
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

        printf("Note en prog C %i :\n ", (i+1));
        scanf("%f", &((p+i)->prog_C)); 

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


#define nb_eleves 1


int main (void)
{

    data eleves[5] =
    {
        {"nom 1", "prenom 1", "addresse 1", "note 1.1", "note 1.1"},
        {"nom 2", "prenom 2", "addresse 2", "note 2.1", "note 2.1"},
        {"nom 3", "prenom 3", "addresse 3", "note 3.1", "note 3.1"},
        {"nom 4", "prenom 4", "addresse 4", "note 4.1", "note 4.1"},
        {"nom 5", "prenom 5", "addresse 5", "note 5.1", "note 5.1"}

    };; // on crée un tableau de structures de type data

    // on crée nos eleves
    creat_eleves(eleves, nb_eleves);

    // on affiche les données de nos elèves
    disp_eleves(eleves, nb_eleves);
}
