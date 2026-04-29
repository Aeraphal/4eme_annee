#include "myWindow.hpp"

#include "myWidgetGL.hpp"
#include "ui_mainwindow.h"

#include <iostream>


myWindow::myWindow(QWidget *parent)
    :QMainWindow(parent),ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    std::cout<<"Create OpenGL Widget"<<std::endl;

    QGLFormat qglFormat;
    qglFormat.setVersion(1,2);
    glWidget=new myWidgetGL(qglFormat);
    ui->layout_scene->addWidget(glWidget);

    connect(ui->quit,SIGNAL(clicked()),this,SLOT(action_quit()));
    connect(ui->draw,SIGNAL(clicked()),this,SLOT(action_draw()));
    connect(ui->wireframe,SIGNAL(clicked()),this,SLOT(action_wireframe()));

}

myWindow::~myWindow()
{}

void myWindow::action_quit()
{
    close();
}

void myWindow::action_draw()
{
    glWidget->draw();
}

void myWindow::action_wireframe()
{
    bool state_wireframe=ui->wireframe->isChecked();
    glWidget->wireframe(state_wireframe);
}

