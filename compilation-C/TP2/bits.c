#include <stdio.h>




int main()
{
    

    /* Avec un mask */
    int variable= 589825 ;
    int init_variable = variable;
    long long int mask = 65537;
    int iarray[64];
    int verif = 0;

    //initialisation du tableau à 0
    for (int a = 0; a <= 64; a++)
    {
        iarray[a] = 0;
    }

    // On réduit le nombre à 20 bits en supprimant les bits de droite
    while(variable > 1048575)
    {
        
        // on décale notre variable à droite afin d'atteindre et comparer le bit de poids fort
        variable = variable >> 1;
    }
    printf("La variable : %d\n", variable);

    printf("La variable initiale : %d\n", init_variable);
    
    printf("Le masque : %lld\n", mask);

    printf("Le & Logique (mask&variable) : %lld\n\n", mask & variable);



    printf("Le nombre binaire de %d ", init_variable);

    verif = mask & variable;
    // On vérifie que les 4èmes et 20èmes bits de points fort sont présent et que le nombre a au moins 20 bits
    if (verif == mask && init_variable > 524288)
    {
        printf("a le quatrième et vingtième bit égals à 1 en partant de la gauche.");
    }

    else 
    {
        printf("n'a pas le quatrième et vingtième bit égals à 1 en partant de la gauche.");
    }

    printf("\n\n");


    return 0;
}

