//inclusion de la bibliothèque de vecteur de la STL
#include <vector>
//inclusion de la bibliothèque de flux d’affichage (pour std::cout)
#include <iostream>

int main()
{
    std::vector<int> V = {1,4,7,8,2};
    std::list<std::string> const L = {"this","is","a short","text"};
    //passage par copie
    //modification impossible des valeurs
    for(int value : V)
        std::cout<<value<<" ";
    std::cout<<std::endl;
    //passage par copie (type déterminé automatiquement).
    //modification impossible des valeurs
    for(auto value : V)
        std::cout<<value<<" ";
    std::cout<<std::endl;
    //passage par référence
    //modification possible des valeurs
    for(int& value : V)
    {
        value = value+1;
        std::cout<<value<<" ";
    }
    std::cout<<std::endl;
    //passage par référence (type déterminé automatiquement)
    //modification possible des valeurs
    for(auto& value : V)
    {
        value = value+1;
        std::cout<<value<<" ";
    }
    std::cout<<std::endl;
    //passage par référence constante
    //modification impossible des valeurs
    for(std::string const& value : L)
        std::cout<<value<<" ";
    std::cout<<std::endl;
    //passage par référence constante
    //modification impossible des valeurs
    for(auto const& value : L)
        std::cout<<value<<" ";
    std::cout<<std::endl;
    return 0;
}