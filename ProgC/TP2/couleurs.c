/*int main()
//{
    // on créer notre structure de 10 couleurs
    couleurs colors = {
                        { "abricot", 0xe6 , 0x7e, 0x30},
                        { "absinthe", 0x7f, 0xdd, 0x4c},
                        { "acajou", 0x88, 0x42, 0x1d},
                        { "aigue-marine", 0x79, 0xf8, 0xf8},
                        { "noir", 0x00, 0x00, 0x00},
                        { "albatre", 0xfe, 0xfe, 0xfe},
                        { "amarante", 0x91, 0x2b, 0x3b},
                        { "ardoise", 0x5a, 0x5e, 0x6b},
                        { "azur", 0x74, 0xd0, 0xf1},
                        { "aurore", 0xff, 0xcb, 0x60},
                     };

}*/

//biblioteques
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

struct Couleur
{
    int R;
    int G;
    int B;
    int A;
};


int main() 
{   
    srand( time( NULL ) );

    int n;
    int R , G , B , A ;
    int taille = 10;

    struct Couleur couleur;
    
    int intamax = 256;
    int intmin = 0;
    int total = 0;

    struct Couleur Couleurs[taille];

    struct Couleur Couleursdistinct[taille];

    int Nbocur[taille];
    

   

     
    for (int i = 0; i <= (taille-1); i++) 
    {
        couleur.R = rand() % intamax;
        couleur.G = rand() % intamax;
        couleur.B = rand() % intamax;
        couleur.A = rand() % intamax;

        Couleurs[i] = couleur; 
    }

    for (int i = 0; i <= (taille-1); i++)
    {
        R = Couleurs[i].R;
        G = Couleurs[i].G;
        B = Couleurs[i].B;
        A = Couleurs[i].A;
    }
    
    for (int i = 0; i <= (taille-1); i++) 
    {
        
    
        R =Couleurs[i].R;
        G =Couleurs[i].G;
        B =Couleurs[i].B;
        A =Couleurs[i].A;
        n = Nbocur[i];
        total = total + n;

        printf(" R = %x ; G = %x ; B = %x ; A = %x \n", R,G,B,A);
    }
    /*printf("total%i\n", total);
    printf("nbdistinct%i\n", nbdistinct);*/
    return 0; 
}