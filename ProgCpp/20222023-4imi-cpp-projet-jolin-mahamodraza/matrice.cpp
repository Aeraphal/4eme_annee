#include <stdio.h>
#include "matrice.hpp"
#include <vector>
#include <string>
#include <iostream>

template<typename T>

Matrice::Matrice(std::size_t ligne, std::size_t colonne, const std::vector<T>& valeur)
    {
    ligne_ = ligne;
    colonne_ = colonne;
    valeur_ = valeur;
    
    }

Matrice::Matrice(std::size_t ligne,  std::size_t colonne, const  T& val) : ligne_{ligne}, colonne_{colonne},  valeur_{std::vector<T>(ligne * colonne, val)}{ }

        
void print() {          
    for (int i = 0; i < ligne_; i++) {
        std::cout << '{';
        for (int j = 0; j < colonne_; j++) {
            std::cout << " " <<valeur_[colonne_*i + j]<< " ";
            }
    std::cout << "}\n";
        }
    }






int main(){
    std::vector datatest    = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 
                              2, 0, 0, 0, 0 ,0, 0, 0, 0 ,2, 
                              2, 0, 0, 0, 0 ,0, 0, 0, 0 ,2,
                              2, 0, 0, 0, 0 ,0, 0, 0, 0 ,2,
                              2, 0, 0, 0, 0 ,0, 0, 0, 0 ,2,
                              2, 0, 0, 0, 1 ,0, 0, 0, 0 ,2,
                              2, 0, 0, 0, 0 ,0, 0, 0, 0 ,2,
                              2, 0, 0, 0, 0 ,0, 0, 0, 0 ,2,
                              2, 0, 0, 0, 0 ,0, 0, 0, 0 ,2,
                              2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
    Matrice maptest(10, 10, datatest);
    

    maptest.print();
    
    
    
    return(0);
};