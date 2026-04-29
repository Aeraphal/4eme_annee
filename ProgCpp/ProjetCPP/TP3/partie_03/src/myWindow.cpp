#include "myWindow.hpp"

#include <QPushButton>
#include <QGridLayout>
#include <QCheckBox>

#include <iostream>

myWindow::myWindow(QWidget *parent)
  :QWidget(parent)
{
    std::cout<<"Generate the new Window"<<std::endl;

    //Create the buttons
    quitButton = new QPushButton("Quit");
    checkBox1  = new QCheckBox(QString("select option 1"));
    checkBox2  = new QCheckBox(QString("select option 2"));

    //Create the grid layout
    mainLayout = new QGridLayout;

    //Add the buttons in the grid layout
    mainLayout->addWidget(checkBox1,0,1);
    mainLayout->addWidget(checkBox2,0,2);
    mainLayout->addWidget(quitButton,1,3);

    //Manage signals and slots
    // = setup the links between the click on a button and the call of a function
    connect(quitButton,SIGNAL(clicked()),this,SLOT(quitWindow()) );
    connect(checkBox1 ,SIGNAL(clicked()),this,SLOT(clickButton()));
    connect(checkBox2 ,SIGNAL(clicked()),this,SLOT(clickButton()));

    //Add the layout to the current window
    this->setLayout(mainLayout);
    this->setWindowTitle(tr("My Window"));
}

myWindow::~myWindow()
{
    std::cout<<"Destructor of myWindow is called"<<std::endl;
}

void myWindow::quitWindow()
{
  std::cout<<"myWindow wants to quit"<<std::endl;
  this->window()->close();
}

void myWindow::clickButton()
{
    std::cout<<"Click on a button, new current state: ("<<checkBox1->isChecked()<<","<<checkBox2->isChecked()<<")"<<std::endl;
}

