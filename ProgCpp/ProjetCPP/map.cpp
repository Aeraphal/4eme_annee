#include "map.hpp"
#define Map

#include <stdio.h>
#include <string>

enum Couleur {lime=1, green=2, yellow, orange, red, brown, black};

class MAP
{
    private:
    int Vide;
    int Personnage;
    int Depart;
    int Obstacle;
    int Loot;
    int CoordX;
    int CoordY;
    public:
    MAP::MAP()
    :Vide(0),Personnage(1),Depart(2),Obstacle(4),Loot(8),CoordX(0),CoordY(0){}

    // int * getcoord(Descendant){
    //     return Descendant.coord;
    // }
    
    int MAP::getX() const{
        return(CoordX);
    }
    
    int MAP::getY() const{
        return(CoordY);
    }
    
    


    // void Deplacement_perso(){
    //     getcoord(int Descendant)
    //     Descendant.endurance -= 1;
    //     if (Descendant.endurance == 0){
    //         Mort();
    //     }
    // }
    void MAP::Mort(Personnage &cible)
    {
        if (cible.estVivant == False);
        CoordX, CoordY = Depart.coord;
        cible = new Personnage(int 50);
    }
};

int main(){
    return(0);
};