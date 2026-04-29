
#include <QApplication>
#include <iostream>

//personnal class of window
#include "myWindow.hpp"

int main(int argc,char *argv[])
{
  QApplication app(argc,argv);
  myWindow window;

  std::cout<<"Draw a window"<<std::endl;
  window.show();

  std::cout<<"Start the main application"<<std::endl;
  return app.exec();
}
