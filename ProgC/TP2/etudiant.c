#include <stdio.h>

/*----------------------------------------------------------------*/
 void creat_eleves(char  *p, int nb, int infos, int taille)
 {


    while (int i =0; i < nb*infos*taille)// on crée nb eleves
    {
      // on stocke dans la case i du tableau un tableau de 5 cases 
        printf(" Informations eleve %i :\n ", (i+1) );

        printf("\nPrénom de l'eleve : ");
        scanf("%s", (p+i)); // premièere case du premier sous-tableau de la premiere case du tableau global, soit la première case pour chaque elève dans le tableau global
        
        printf("\nNom de l'eleve : ");
        scanf("%s", (p+i+20)  ); 

        printf("\nAdresse de l'eleve : ");
        scanf("%s", (p+i+40)  ); 

        printf("\nNote en Prog C de l'eleve : ");
        scanf("%f", &((p+i+60) ) ); 

        printf("\nNote en Sys d'exploitation de l'eleve : ");
        scanf("%f", &((p+i+80)) ); 

        i+= 5*20; // on update le i pour qu'il soit sur la case siuvante du tableau global, soit l'élève suivant
        
    }
 }

/*----------------------------------------------------------------*/

/*----------------------------------------------------------------*/
 void disp_eleves(char  *p, int nb)
 {

    for (int i =0; i < nb; i++)// on crée 5 eleves
    {
        printf(" Elève %i ", i+1);
        printf("Prenom : \n%s :\n ", (p+i)[0]);//*(p+i).prenom
        
        printf("Nom : \n %s :\n ", (p+i)[1]);

        printf("Adresse : \n %s :\n ", (p+i)[2]);

        printf("Note prog_c : \n %s :\n ", (p+i)[3]);
     
        printf("Note sys_exp : \n %s :\n ", (p+i)[4]);
        
    }
 }

/*----------------------------------------------------------------*/


#define nb_eleves 5 // le nombre d'élèves dont il faut renseigner les données
#define nb_infos 5 // le nb d'info sur chaque élève
#define taille_max 20 // taille de chaine de carat max par info

int main (void)
{
    char eleves[nb_eleves][nb_info][taille_max];

    // on crée nos eleves
    creat_eleves(eleves, &(eleves[0][0]), nb_eleves, nb_infos, taille_max);

    // on affiche les données de nos elèves
    disp_eleves(eleves, nb_eleves);
}