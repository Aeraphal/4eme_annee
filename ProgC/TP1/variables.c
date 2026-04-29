#include <stdio.h>

int main ()
{
    char a = 'a';
    unsigned char b = 'b';

    short c = -2;
    unsigned short d = 2;

    int e = -5;
    unsigned int f= 5 ;

    long int g =-215646;
    unsigned long int h =5614565;

    long long int i =-545644 ;
    unsigned long long int j = 56564151545;

    float k = 3.14;
    double l = 3.141515845;
    long double m = 3.4949494189458945144549;

    printf("la variable char  %c\n", a); 
    printf("la variable unsigned_char %hhu\n\n", b); 

    printf("la variable short %hd\n", c); 
    printf("la variable unsigned short %hu\n\n",  d); 

    printf("la variable int %d\n", e);  
    printf("la variable unsigned int %u\n\n", f); 

    printf("la variable long int %ld\n", g);
    printf("la variable unsigned long int %lu\n\n", h);  

    printf("la variable long long int %lld\n", i); 
    printf("la variable unsigned long long int %llu\n\n", j); 

    printf("la variable float %f\n", k);
    printf("la variable double %g\n", l); 
    printf("la variable long double %Lg\n", m);
    return 0;

}
