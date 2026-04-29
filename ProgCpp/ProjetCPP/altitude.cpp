#include "altitude.hpp"
#define Altitude

#include <stdio.h>
#include <string>
// Librairie Random
#include <stdlib.h>

class Altitude
{
    public:
    // Méthode


    // Attribut
    private:
    
    int* m_Tableau;
    int m_Var_alt;



    public:
        Altitude(std::size_t ligne, std::size_t colonne)
        {
            ligne_ = ligne;
            colonne_ = colonne;
        }
        Altitude(std::size_t ligne, std::size_t colonne)
            : ligne_{ligne}, colonne_{colonne}{}

        void print()
        {
            for (int i = 0; i<ligne_*colonne_;i++) {
                std::cout
            } 
        }
};

