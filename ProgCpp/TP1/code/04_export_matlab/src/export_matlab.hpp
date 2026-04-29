#pragma once

#ifndef EXPORT_MATLAB_HPP
#define EXPORT_MATLAB_HPP

#include <iostream>
#include <fstream>

// Export data container as a Matlab structure in the file [filename].
template <typename DATA>
void export_matlab(DATA const& data , std::string const& filename = "data.m")
{
    //Open file
    std::ofstream ofs(filename.c_str());

    //check file is open
    if(ofs.good()!=true)
    {
        std::cerr<<"Cannot open file "<<filename<<std::endl;
        exit(1);
    }

    //write header in Matlab style
    ofs<<"DATA=[";

    //write data in Matlab style
    for(auto const& value : data)
    {
        std::string data_str=to_string(value,";");
        ofs<<"["<<data_str<<"] ";
    }

    ofs<<"];";

    ofs.close();

}



#endif
