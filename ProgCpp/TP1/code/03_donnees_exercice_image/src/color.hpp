
#pragma once

#ifndef COLOR_HPP
#define COLOR_HPP

#include <iostream>

struct color
{
    /** \brief Composante rouge de la couleur **/
    int r;
    /** \brief Composante verte de la couleur **/
    int g;
    /** \brief Composante bleue de la couleur **/
    int b;


    /** \brief Construteur vide
     * Initialise les paramètres à 0
     **/
    color();
    /** \brief Construteur  **/
    color(int r_arg,int g_arg,int b_arg);
};



/** \brief Envoie d'une couleur sur un flux de sortie
 * La couleur est envoyee sous la forme "r g b"
 **/
std::ostream& operator<<(std::ostream& stream,color const& c);

/** \brief Verifie qu'une couleur est valide
 *  \note Une couleur est valide si les 3 composantes r,g, et b
 * sont toutes les trois comprises entre [0,255].
 *  \return true : si la couleur est valide, false sinon
 **/
bool is_valid(color const& c);

#endif
