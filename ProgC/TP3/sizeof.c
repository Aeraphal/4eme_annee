#include <stdio.h>

int main (void)
{
    printf("taille int : %ld\n", sizeof(int) );

    printf("taille int * : %ld\n", sizeof(int *) );

    printf("taille int ** : %ld\n", sizeof (int **));

    printf("taille char * : %ld\n", sizeof (char *) );

    printf("taille char ** : %ld\n", sizeof (char **) );

    printf("taille char *** : %ld\n", sizeof (char ***) );

    printf("taille float * : %ld\n", sizeof (float *) );

    printf("taille float ** : %ld\n", sizeof (float **) );

    printf("taille float *** : %ld\n", sizeof (float ***));

}

