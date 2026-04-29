
#include "color.hpp"

color::color()
    :r(0),g(0),b(0)
{

}

color::color(int r_arg,int g_arg,int b_arg)
    :r(r_arg),g(g_arg),b(b_arg)
{

}



std::ostream& operator<<(std::ostream& stream,color const& c)
{
    stream<<c.r<<" "<<c.g<<" "<<c.b;
    return stream;
}

bool is_valid(color const& c)
{
    if(c.r<0 || c.r>255 || c.g<0 || c.g>255 || c.b<0 || c.b>255)
        return false;
    return true;
}
