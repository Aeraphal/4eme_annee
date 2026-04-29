
#include "image.hpp"

#include <cstdlib>

void image::assert_coord(int x,int y) const
{
    if(x<0 || x>=Nx || y<0 || y>=Ny)
    {
        std::cerr<<"Index "<<x<<","<<y<<" hors bornes."<<std::endl;
        exit(1);
    }
}

const color& image::operator()(int x,int y) const
{
    assert_coord(x,y);
    return data[y+Ny*x];
}
color& image::operator()(int x,int y)
{
    assert_coord(x,y);
    return data[y+Ny*x];
}

void image::resize(int Nx_arg,int Ny_arg)
{
    Nx=Nx_arg;
    Ny=Ny_arg;
    data.resize(Nx_arg*Ny_arg);
}
