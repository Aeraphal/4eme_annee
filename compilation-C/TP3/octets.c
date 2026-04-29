# include <stdio.h>


int main()
{
    char type = 'int';
    
    switch(type)
    {
        case 'int':
            int a =0;
            char*p =(char) &a; // on transforme l'adresse de a en chaine de caracteres, et on donne l'adressede la première case au pointeur

            for(int i=0; i<sizeof(a), i++)
            {
                printf("%hhx", *p); // on affiche la valeur de l'octet
                p++; // on passe à l'octet suivant
            }
            break;
        
        case 'long int':
            long int a =0;
            char*p =(char) &a; // on transforme l'adresse de a en chaine de caracteres, et on donne l'adressede la première case au pointeur

            for(int i=0; i<sizeof(a), i++)
            {
                printf("%hhx", *p); // on affiche la valeur de l'octet
                p++; // on passe à l'octet suivant
            }
            break;
        
        case 'short':
            short a =0;
            char*p =(char) &a; // on transforme l'adresse de a en chaine de caracteres, et on donne l'adressede la première case au pointeur

            for(int i=0; i<sizeof(a), i++)
            {
                printf("%hhx", *p); // on affiche la valeur de l'octet
                p++; // on passe à l'octet suivant
            }
            break;
        
        case 'float':
            float a =0;
            char*p =(char) &a; // on transforme l'adresse de a en chaine de caracteres, et on donne l'adressede la première case au pointeur

            for(int i=0; i<sizeof(a), i++)
            {
                printf("%hhx", *p); // on affiche la valeur de l'octet
                p++; // on passe à l'octet suivant
            }
            break;
        
        case 'double':
            double a =0;
            char*p =(char) &a; // on transforme l'adresse de a en chaine de caracteres, et on donne l'adressede la première case au pointeur

            for(int i=0; i<sizeof(a), i++)
            {
                printf("%hhx", *p); // on affiche la valeur de l'octet
                p++; // on passe à l'octet suivant
            }
            break;
        
        case 'long double':
            long double a =0;
            char*p =(char) &a; // on transforme l'adresse de a en chaine de caracteres, et on donne l'adressede la première case au pointeur

            for(int i=0; i<sizeof(a), i++)
            {
                printf("%hhx", *p); // on affiche la valeur de l'octet
                p++; // on passe à l'octet suivant
            }
            break;
        
        default:
            printf("\nType de variable non reconnu \n");
    }

}