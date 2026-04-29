#include <iostream>
#include <string>

struct Conteneur
{
    int N;
    std::string M;
    void affiche()
    {
        std::cout<<"Je contiens l'entier "<<N<<" et le mot "<<M<<"."<<std::endl;
    }
};

struct personne
{
    std::string Nom;
    std::string Prenom;
    personne()
    {
        Nom="Inconnu";Prenom="Inconnu";
    }
    personne(std::string Vrai_Nom, std::string Vrai_Prenom)
    {
        Nom=Vrai_Nom;Prenom=Vrai_Prenom;
    }

};


int main()
{
    std::string variable="Ma variable";
    variable += " a moi.";
    std::cout<<variable<<std::endl;

    Conteneur conteneur_1;
    conteneur_1.N = 6;
    conteneur_1.M = "coucou";
    conteneur_1.affiche();
    Conteneur conteneur_2 = {4,"bonjour"};
    conteneur_2.affiche();
    
    Conteneur tableau[]={ {18,"poisson"},
                        {12,"charcuterie"},
                        {2,"soda"},
                        {0,"eau"} };
    for(auto valeur : tableau)
        valeur.affiche();
    
    return 0;
}