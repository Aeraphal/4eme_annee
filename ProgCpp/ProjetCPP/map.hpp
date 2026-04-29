#ifndef DEF_MAP
#define DEF_MAP

#include <string>

class Personnage
{
    public:
    MAP(); // Constructeur
    //Méthode
    int getX() const;
    int getY() const;
    void Mort(Personnage &cible);
    //Attribut
    private:
    int Vide;
    int Personnage;
    int Depart;
    int Obstacle;
    int Loot;
    int CoordX;
    int CoordY;
}