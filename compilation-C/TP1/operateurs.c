#include <stdio.h>

int main ()
{

    int a = 16;
    int b = 3;

    

    printf("l'addition de A et B %d\n", a+b);
    printf("la soustraction de A et B %d\n", a-b); 
    printf("la multiplication de A et B %d\n", a*b);
    printf("la division euclidienne de A et B %d\n", a/b);
    printf("le reste de la division euclidienne de A et B %d\n\n", a%b);

    printf("A plus grand que B %d\n", a > b);
    printf("A plus grand ou égal à B %d\n", a >= b);
    printf("A plus petit que B %d\n", a < b);
    printf("A plus petit ou égale à B %d\n", a <= b);
    printf("A est égale à B %d\n", a == b);
    printf("A different à B %d\n\n", a != b);

    printf("A est négationniste %d\n", !a);
    printf("A 'et' logique B %d\n", a&&b);
    printf("A 'ou' logique B %d\n", a || b);

    return 0;

}

