#pragma once

#ifndef GRILLE_HPP 
#define GRILLE_HPP

#include <vector>

template <typename T>
class Grille
{
    /** \brief La taille suivant x de l'image **/
    int Nx;
    /** \brief La taille suivant y de l'image **/
    int Ny;

    /** \brief Les donnees de l'image **/
    std::vector<T> data;

    /** Certifie que (x,y) soit bien contenu dans l'image
     *  \return rien, mais quitte si les coordonnee sont hors de l'image
     **/
    void assert_coord(int x,int y) const;

    /** \brief Operateur "get" pour des coordonnees (x,y) **/
    T const& operator()(int x,int y) const;

    /** \brief Operateur "get/set" pour des coordonnees (x,y) **/
    T& operator()(int x,int y);

    /** \brief Redimentionne l'image a une nouvelle taille
      * Les parametres (Nx,Ny) sont remis a jour, et le vecteur
      * de donnees est redimensionne (mais il n'efface pas les donnees
      * precedente).
      **/
    void resize(int Nx_arg,int Ny_arg);
};

template <typename T>
class World : public Grille<T*>
{

    void resize(int Nx_arg,int Ny_arg)
    { Nx = Nx_arg; Ny = Ny_arg;
      data.resize(Nx*Ny);
      for(auto& c : data)
      {
        c = new T;
      }
    }
};
template <typename T>
std::ostream& operator<<(std::ostream& os, const World<T>& w)
{
  for (i ...)
    for(j ....)
      os << w(i, j);
  return os;
}

class Case
{
};
std::ostream& operator<<(std::ostream& os, const Case& c)
{
  os << '.';
  return os;
}

class Ressource : public Case
{
};
std::ostream& operator<<(std::ostream& os, const Ressource& r)
{
  os << 'R';
  return os;
}

int main()
{
  Grille<Case*> g;
  g.resize(10, 10);


}


#endif
