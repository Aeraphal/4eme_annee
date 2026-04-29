#include <stdio.h>

int main ()
{
    int compteur = 1000;

    for (int i=0; i <= compteur; i++)
    {
        
        if (i%2 == 0 && i%15 == 0)
        {
            printf("%i est divisible par 2 et 15\n", i);
        }

        else if (i%103 == 0 || i % 107 ==0)
        {
            printf("%i est divisible par 103 ou 107\n", i);
        }

        else if ( (i%7 == 0 || i%5 == 0) && i%3)
        {
            /*if (i%3 =! 0)
            {}*/
            printf("%i est divisible par 5 ou 7 mais pas par 3\n", i);

        }

    }

    printf("\n");
    return 0;    

}