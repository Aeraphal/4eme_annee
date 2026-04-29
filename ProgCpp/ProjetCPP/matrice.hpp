#ifndef DEF_MATRICE
#define DEF_MATRICE

#include <string>

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
}