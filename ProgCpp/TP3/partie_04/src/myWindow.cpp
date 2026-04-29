
#include "myWindow.hpp"

#include "ui_mainwindow.h"

#include <iostream>
#include <QtGui>



myWindow::myWindow(QWidget *parent)
    :QMainWindow(parent),ui(new Ui::MainWindow)
{
    std::cout<<"Generate the new Window"<<std::endl;

    //Setup the graphical layout on this current Widget
    ui->setupUi(this);

    //Links buttons and actions
    connect(ui->checkBox,SIGNAL(clicked()),this,SLOT(actionCheckBox1()));
    connect(ui->checkBox_2,SIGNAL(clicked()),this,SLOT(actionCheckBox2()));
    connect(ui->Button_1,SIGNAL(clicked()),this,SLOT(actionButton1()));
    connect(ui->Button_2,SIGNAL(clicked()),this,SLOT(actionButton2()));
    connect(ui->Button_3,SIGNAL(clicked()),this,SLOT(actionButton3()));
    connect(ui->Button_4,SIGNAL(clicked()),this,SLOT(actionButton4()));
    connect(ui->Button_5,SIGNAL(clicked()),this,SLOT(actionButton5()));
    connect(ui->lineEdit,SIGNAL(editingFinished()),this,SLOT(actionTextEdit()));
}

myWindow::~myWindow()
{
    std::cout<<"Destructor of myWindow is called"<<std::endl;
}

void myWindow::actionCheckBox1()
{
    std::cout<<"CheckBox 1 click: "<<ui->checkBox->isChecked()<<std::endl;
}
void myWindow::actionCheckBox2()
{
    std::cout<<"CheckBox 2 click: "<<ui->checkBox_2->isChecked()<<std::endl;
}
void myWindow::actionButton1()
{
    std::cout<<"Button 1 click"<<std::endl;
}
void myWindow::actionButton2()
{
    std::cout<<"Button 2 click"<<std::endl;
}
void myWindow::actionButton3()
{
    std::cout<<"Button 3 click"<<std::endl;
}
void myWindow::actionButton4()
{
    std::cout<<"Button 4 click"<<std::endl;
}
void myWindow::actionButton5()
{
    std::cout<<"Button 5 click"<<std::endl;
}
void myWindow::actionTextEdit()
{
    std::cout<<"Text edit: ["<<ui->lineEdit->text().toStdString()<<"]"<<std::endl;
}
