#include <stdio.h>

int main ()
{
    printf("la taille de char en octet est de %lu\n", sizeof(char)); 
    printf("la taille de unsigned_char en octet est de %lu\n", sizeof(unsigned char)); 

    printf("la taille de short en octet est de %lu\n", sizeof(short)); 
    printf("la taille de unsigned short en octet est de %lu\n", sizeof(unsigned short)); 

    printf("la taille de int en octet est de %lu\n", sizeof(int));  
    printf("la taille de unsigned int en octet est de %lu\n", sizeof(unsigned int)); 

    printf("la taille de long int en octet est de %lu\n", sizeof(long int));
    printf("la taille de unsigned long int en octet est de %lu\n", sizeof(unsigned long int));  

    printf("la taille de long long int en octet est de %lu\n", sizeof(long long int)); 
    printf("la taille de unsigned long long int en octet est de %lu\n", sizeof(unsigned long long int)); 

    printf("la taille de float en octet est de %lu\n", sizeof(float));
    printf("la taille de double en octet est de %lu\n", sizeof(double)); 
    printf("la taille de long double en octet est de %lu\n", sizeof(long double));
    return 0;

}

