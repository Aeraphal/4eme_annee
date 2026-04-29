#ifndef DEF_MATRICE
#define DEF_MATRICE
#include "altitude.hpp"
#include "map.hpp"
#include "pheromone.hpp"
#include <stdio.h>
#include "matrice.hpp"
#include <vector>
#include <string>
#include <iostream>
template<typename T>
class Matrice
{
    public:
    Matrice(std::size_t ligne, std::size_t colonne, const std::vector<T>& valeur); // Constructeur
    //Méthode
    void print();
    //Attribut
    private:
    std::size_t ligne_;
    std::size_t colonne_;
    std::vector<T> valeur_;
    Altitude m_altitude;

};

#endif