#include <stdio.h>

int main ()
{   
    /* classique avec for */ 
    /*int compteur = 5;
    printf("\n```");


    for (int i=0; i <= compteur; i++)
    {
        printf("\n");
        for (int k=0; k<= i; k++)
        {
        
            if (k == 0 || k == i || i == compteur)
            {
                printf("*");
            }

            else
            {
                printf("#");
            }
        }

    }*/

    /* avec while et for */
    int compteur = 5;
    int i = 0;
    printf("\n```\n");

    while (i <= compteur)
    {
        for (int k=0; k<= i; k++)
        {
        
            if (k == 0 || k == i || i == compteur)
            {
                printf("*");
            }

            else
            {
                printf("#");
            }
        }

        i++;
        printf("\n");
    }

    printf("\n```\n");
    return 0;  


}