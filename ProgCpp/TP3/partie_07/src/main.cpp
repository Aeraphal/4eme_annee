
#include <QApplication>
#include <iostream>

#include "myWindow.hpp"

int main(int argc,char *argv[])
{
  QApplication app(argc,argv);
  myWindow window;
  window.show();
  return app.exec();
}
