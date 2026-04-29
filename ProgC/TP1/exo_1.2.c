#include <stdio.h>

int main ()
{
    //  déclaration des variables
    float surface = 0;
    float perimeter = 0;
    float rayon = 1;

    // Calculs
    surface = 3.14 * rayon * rayon;
    perimeter = 2 * rayon * 3.14;

    printf("Il y a une aire de %f cm pour un rayon de %f\n", surface, rayon);
    printf("Il y a un périmètre de %f cm pour un rayon de %f\n", perimeter, rayon);
    
    return 0;
}