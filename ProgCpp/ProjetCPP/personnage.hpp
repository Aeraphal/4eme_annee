#ifndef DEF_PERSONNAGE
#define DEF_PERSONNAGE

#include <string>

class Personnage
{
    public:
    Personnage(); // Constructeur
    ~Personnage(); // Destructeur
    //Méthode
    void Deplacement();
    void Fatigue(int nbtime);
    void Pheromone();
    bool estVivant() const;
    void trouveTresor(int t_Loot);
    bool aTresor() const;
    //Attribut
    private:
    int m_stam;
    int Loot;
}