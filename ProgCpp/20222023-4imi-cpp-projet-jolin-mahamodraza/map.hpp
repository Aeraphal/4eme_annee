#ifndef DEF_MAP
#define DEF_MAP

#include "personnage.hpp"
#include <string>

class MAP
{
    public:
    MAP(); // Constructeur
    //Méthode
    int getX() const;
    int getY() const;
    void Mort(Personnage &cible);
    void DeplacementN();
    void DeplacementS();
    void DeplacementW();
    void DeplacementE();
    //Attribut
    private:
    int Vide;
    int Personnage;
    int Depart;
    int Obstacle;
    int Loot;
    int CoordX;
    int CoordY;
    int* Matrice;
    Personnage m_personnage;
};


#endif