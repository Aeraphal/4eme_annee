#include "personnage.hpp"
#define Personnage

#include <stdio.h>
#include <string>


void Personnage::Deplacement()
{

}

void Personnage::Fatigue(int nbtime)
{
    m_stam -= nbtime
}

void Personnage::Pheromone()
{

}

bool Personnage::estVivant() const
{
    if (m_stam > 0)
    {
        return true
    }
    else
    {
        return false
    }
}

void Personnage::trouveTresor(int t_Loot)
{
    if (t_Loot == 1)
    {
        Loot = 1;
    }
}



bool Personnage::aTresor() const
{
    if (m_loot == 1)
    {
        return true
    }
    else
    {
        return false
    }
}


// Constructeur

Personnage::Personnage() : m_stam(100), Loot(0)
{

}

Personnage::Personnage(int stam) : m_stam(stam), Loot(0)
{

}

// Destruction

Personnage::~Personnage()
{

}