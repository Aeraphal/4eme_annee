/*----------------------------------------------------------------*/
 void disp_eleves(char  *p, int nb, int nb_infos, int taille_chaine)
 {

    for (int i =0; i < nb; i++)// on crée 5 eleves
    {
        printf(" Elève %i \n", i+1);
        printf(" %s \n ", *(p+i*taille_chaine*nb_infos) );//*(p+i).prenom
        
        printf("Nom : %s \n ", (p+i*taille_chaine*nb_infos+20));

        printf("Adresse : %s \n ", (p+i*taille_chaine*nb_infos+40));

        printf("Note prog_c :  %s \n ", (p+i*taille_chaine*nb_infos+60));
     
        printf("Note sys_exp :  %s \n ", (p+i*taille_chaine*nb_infos+80));  
    }
 }

/*----------------------------------------------------------------*/


#define nb_eleves 2 // le nombre d'élèves dont il faut renseigner les données
#define nb_infos 5 // le nb d'info sur chaque élève
#define taille_max 20 // taille de chaine de carat max par info


int main (void)
{
    char eleves[nb_eleves][nb_infos][taille_max]= {
        {"nom 1", "prenom 1", "addresse 1", "note 1.1", "note 1.1"},
        {"nom 2", "prenom 2", "addresse 2", "note 2.1", "note 2.1"},
        {"nom 3", "prenom 3", "addresse 3", "note 3.1", "note 3.1"},
        {"nom 4", "prenom 4", "addresse 4", "note 4.1", "note 4.1"},
        {"nom 5", "prenom 5", "addresse 5", "note 5.1", "note 5.1"}

    };


    // on affiche les données de nos elèves
    disp_eleves(eleves[0][0], nb_eleves, nb_infos, taille_max);
}
