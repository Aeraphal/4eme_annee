#include <stdio.h>
#include "operator.h"

void operateur(char op, int num1, int num2) // fonction qui sert à l'exercie 4.1
{
    switch (op)
    {
        case '+':
            printf("l'addition de num1 et num2 %d\n", num1+num2);
            break;

        case '-':
            printf("la soustraction de num1 et num2 %d\n", num1-num2); 
            break;
        
        case '*':
            printf("la multiplication de num1 et num2 %d\n", num1*num2);
            break;  
    
        case '/':
            printf("la division euclidienne de num1 et num2 %d\n", num1/num2);
            break;
    
        case '%':
        printf("le reste de la division euclidienne de num1 et num2 %d\n", num1%num2);
            break;
    
        case '&':
            printf( "num1  'et' logique num2 %d\n", num1&&num2);
            break;
    
        case '|':
            printf( "num1  'ou' logique num2 %d\n", num1 || num2);
            break;
    
        case '~':
            printf(" négation binaire num1 %d \n", ~ num1);
            break;
        
        default :
                printf(" opérateur non reconnu !");
    }
}
/*--------------------------------------------------------------------------------------------------*/
void operateur_4(int argc, char **argv)// fonction qui sert à l'exercie 4.4
{
    if (argc == 4)// si on a pas pile 4 arguments on teste même pas le programme
    {
        float num1 = (float)argv[2];
        float num2 = (float)argv[3];

        switch (argv[1])
        {
            case '+':
                printf("l'addition de num1 et num2 %d\n", num1+num2);
                break;

            case '-':
                printf("la soustraction de num1 et num2 %d\n", num1-num2); 
                break;
            
            case '*':
                printf("la multiplication de num1 et num2 %d\n", num1*num2);
                break;  
        
            case '/':
                printf("la division euclidienne de num1 et num2 %d\n", num1/num2);
                break;
        
            case '%':
            printf("le reste de la division euclidienne de num1 et num2 %d\n", num1%num2);
                break;
        
            case '&':
                printf( "num1  'et' logique num2 %d\n", num1&&num2);
                break;
        
            case '|':
                printf( "num1  'ou' logique num2 %d\n", num1 || num2);
                break;
        
            case '~':
                printf(" négation binaire num1 %d \n", ~ num1);
                break;
            
            default :
                printf(" opérateur non reconnu !");
        }
    }
}