#include "objet.h"
#define OBJET

#include <stdio.h>
#include <string>

enum Couleur {lime=1, green=2, yellow, orange, red, brown, black}

class MAP
{
    public:
    int Vide;
    int Personnage;
    int Depart;
    int Obstacle;
    int Loot;
    int CoordX;
    int CoordY;
    MAP()
    :Vide(0),Personnage(1),Depart(2),Obstacle(4),Loot(8),CoordX(0),CoordY(0)

    // int * getcoord(Descendant){
    //     return Descendant.coord;
    // }
    
    int getX(){
        return(MAP.CoordX)
    }
    
    int getY(){
        return(MAP.CoordY)
    }
    
    
    void Deplacement_perso(){
        getcoord(int Descendant)
        Descendant.endurance -= 1;
        if (Descendant.endurance == 0){
            Mort();
        }
    }
    void Mort()
    {
        Map(Descendant.coord) = 0;
        Descendant.coord = Depart.coord);
        Descendant.endurance = 100;
    }
}



class Descendant
{
    int index;
    std::string Prenom;
    bool Loot;
    float Pheromone;
    int endurance;
    Descendant()
    {
        index = 1;Prenom="Inconnu";Loot = false; Pheromone = 0, endurance = 50;
    }

}   

class Pere : public Descendant
{
    index = 0;
    float Pheromone;
    Pere(string Prenom, Loot = false, endurance = 10000);
}

struct Altitude
{
    int ** Alt;
    Altitude()
    {
        int k = 1;
    }

}


