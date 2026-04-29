
#include <QApplication>
#include <iostream>

#include "window.hpp"


int main(int argc,char *argv[])
{
  QApplication app(argc,argv);
  window win;

  std::cout<<"Draw the window"<<std::endl;
  win.show();

  std::cout<<"Start the main application"<<std::endl;
  return app.exec();
}
