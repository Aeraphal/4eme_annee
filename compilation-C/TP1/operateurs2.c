#include <stdio.h>

int main ()
{

    int num1 = 16;
    int num2 = 3; 
    char op = '+';

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

    
    }


    return 0;

}
