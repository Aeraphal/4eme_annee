//inclusion de la bibliothèque de vecteur de la STL
#include <vector>
//inclusion de la bibliothèque de flux d’affichage (pour std::cout)
#include <iostream>
int main()
{
    //definition d’un vecteur de nom: mon_vecteur stockant des entiers
    std::vector<int> mon_vecteur;
    //redimensionnement de mon_vecteur a une taille de 3
    // il peut alors stocker 3 int
    mon_vecteur.resize(3);
    //affectation de valeurs (similaire a un tableau standard)
    mon_vecteur[0]=1;
    mon_vecteur[1]=-2;
    mon_vecteur[2]=5;
    //recuperation de la taille d’un vecteur
    int N=mon_vecteur.size(); //ici N=3
    //parcours du vecteur (version indicee)
    for(int k=0;k<N;++k)
        std::cout<<mon_vecteur[k]<<" ";
    std::cout<<std::endl;
    //parcours du vecteur (version "range-based loop" (c++11))
    for(int valeur : mon_vecteur)
        std::cout<<valeur<<" ";
    std::cout<<std::endl;
    //parcours du vecteur (version iterateur courte (c++11))
    for(auto it=mon_vecteur.begin(),it_end=mon_vecteur.end();
    it!=it_end;++it)
        std::cout<<*it<<" ";
    std::cout<<std::endl;
    //parcours du vecteur (version iterateur longue)
    std::vector<int>::iterator it=mon_vecteur.begin(),
    it_end=mon_vecteur.end();
    for(;it!=it_end;++it)
        std::cout<<*it<<" ";
    std::cout<<std::endl;
    //ajout en fin de vecteur avec redimensionnement automatique
    mon_vecteur.push_back(8);
    mon_vecteur.push_back(-1);
    //verification de la nouvelle taille
    std::cout<<mon_vecteur.size()<<std::endl;//affiche 5
    //on peut copier des vecteurs termes a termes (version courte (c++11))
    auto autre_vecteur=mon_vecteur;
    //on peut copier des vecteurs termes a termes (version longue)
    std::vector<int> autre_vecteur2; //1-creation de la classe
    autre_vecteur2=mon_vecteur; //2-copie des elements
    //lorsque l’on quitte la fonction les vecteurs liberent automatiquement
    // la memoire qu’ils ont alloues.
    return 0;
}