

#include <QApplication>
#include <iostream>

#include "myWindow.hpp"


int main(int argc,char *argv[])
{
  QApplication app(argc,argv);
  myWindow window;

  std::cout<<"Draw the window"<<std::endl;
  window.show();

  std::cout<<"Start the main application"<<std::endl;
  return app.exec();
}
