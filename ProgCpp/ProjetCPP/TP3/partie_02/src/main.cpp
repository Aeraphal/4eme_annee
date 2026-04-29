
#include <QApplication>
#include <QPushButton>
#include <QCheckBox>
#include <QGridLayout>



int main(int argc,char *argv[])
{
    QApplication app(argc,argv);

    //create buttons
    QPushButton *quitButton = new QPushButton("Quit");
    QCheckBox *checkBox1    = new QCheckBox( QString("select option 1") );
    QCheckBox *checkBox2    = new QCheckBox( QString("select option 2") );

    //A layout manager that places buttons within a grid
    QGridLayout *mainLayout = new QGridLayout;

    //Add the buttons within the grid of the layout manager
    mainLayout->addWidget(checkBox1,0,1);
    mainLayout->addWidget(checkBox2,0,2);
    mainLayout->addWidget(quitButton,1,3);


    //The graphical element which is displayed
    QWidget *myWidget = new QWidget;

    //Add the layout manager to the widget (note that all the buttons goes with the layout)
    myWidget->setLayout(mainLayout);
    //The title of the graphical element
    myWidget->setWindowTitle(QString("My application"));
    //Set the graphical element to be visible
    myWidget->show();

    return app.exec();
}

