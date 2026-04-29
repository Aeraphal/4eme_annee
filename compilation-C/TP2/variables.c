
void recup_hexa(char nom_variable, float *variable)
{
    long int mask = 1;
    char values[8];// tacbleau qui stocke les valeurs de chaque groupes de 4 bits
    char *p_v = &values;// première case du tableau
    
    for (int i =0; i< 8; i++) // pour chaque case du tableau de valeurs à trouver, on se place sur les 4 bits de poids faibles pour le première boucle puis on remonte par groupe de 4 pour avoir la conversion en hexa
    {
        int val = 0; // la valeur à matre dans la case i du tableau
        for(int a=0; a<3; a++) // on calcul le decimal sur 4 bits
        {
            val += *variable&mask; // on récupère l'état du bit qui nous interesse
            mask = mask<<1; // on de deplace le 1 du mask de 1 vers la droite
        }
        // conversion en hexadecimal pour les a,b,c,d,e,f
       switch(val)
       {
            case 10:
                values[i] = 'a';
                break;

            case 11:
                values[i] = 'b';
                break;

            case 12:
                values[i] = 'c';
                break;
            
            case 13:
                values[i] = 'd';
                break;
            
            case 14:
                values[i] = 'e';
                break;
            
            case 15:
                values[i] = 'f';
                break;
            
            default:
                values[i]=(char) val;
       }

    }


    printf(" \n %s : ", nom_variable);
    for(int i=0; i<4; i++)
    {
        printf("%p %p ", *(p_v+i), *(p_v+i+1)); // on affiche par regroupement de 2
    }
}


int main(void)
{
   int i = 0xa47865ff; 
   float f = 1;

   recup_hexa('i', &i);
}