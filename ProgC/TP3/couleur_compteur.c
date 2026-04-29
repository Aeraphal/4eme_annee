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
    int R2 , G2 , B2 , A2 ;

    int taille = 100;

    struct Couleur couleur;

    
    int nbdistinct =0;
    int dejavu = 0;
    
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
        dejavu = 0;

        for (int j = 0; j < nbdistinct; j++)
        {   
           
            R2 = Couleursdistinct[j].R;
            G2 = Couleursdistinct[j].G;
            B2 = Couleursdistinct[j].B;
            A2 = Couleursdistinct[j].A;
            if (R==R2 && G==G2 && B==B2 && A==A2) 
            {
                dejavu = 1;
                break;
            }  

        }

        if (dejavu == 0 )
        {
            Couleursdistinct[nbdistinct].R = R;
            Couleursdistinct[nbdistinct].G = G;
            Couleursdistinct[nbdistinct].B = B;
            Couleursdistinct[nbdistinct].A = A;

            Nbocur[nbdistinct] = 1;

            for (int k  = i+1; k <= (taille-1); k++)
            {
                R2 = Couleurs[k].R;
                G2 = Couleurs[k].G;
                B2 = Couleurs[k].B;
                A2 = Couleurs[k].A;

                if (R==R2 && G==G2 && B==B2 && A==A2) 
                {
                    Nbocur[nbdistinct]= Nbocur[nbdistinct]+1;
                }  
            }
            nbdistinct = nbdistinct + 1;
        }



    }

    /*for (int i = 0; i <= (taille-1); i++) 
    {
        int R , G , B , A ;
    
        R =Couleurs[i].R;
        G =Couleurs[i].G;
        B =Couleurs[i].B;
        A =Couleurs[i].A;

        printf("Voici les couleurs : R = %x ; G = %x ; B = %x ; A = %x \n", R,G,B,A);
    }*/

    
    for (int i = 0; i <= (nbdistinct-1); i++) 
    {
        
    
        R =Couleursdistinct[i].R;
        G =Couleursdistinct[i].G;
        B =Couleursdistinct[i].B;
        A =Couleursdistinct[i].A;
        n = Nbocur[i];
        total = total + n;

        printf("Voici une couleur distincte : R = %x ; G = %x ; B = %x ; A = %x elle est presente %i fois \n", R,G,B,A,n);
    }
    /*printf("total%i\n", total);
    printf("nbdistinct%i\n", nbdistinct);*/
    return 0; 
}





