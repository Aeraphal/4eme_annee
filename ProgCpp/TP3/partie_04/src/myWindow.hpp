#pragma once

#ifndef MYWINDOW_HPP
#define MYWINDOW_HPP

#include <QMainWindow>


//Forward declaration of Ui::MainWindow;
namespace Ui{
class MainWindow;
}

//Declaration of myWindow
class myWindow: public QMainWindow
{
    Q_OBJECT

public:

    myWindow(QWidget *parent=nullptr);
    ~myWindow();

private slots:
    void actionCheckBox1();
    void actionCheckBox2();
    void actionButton1();
    void actionButton2();
    void actionButton3();
    void actionButton4();
    void actionButton5();
    void actionTextEdit();

private:

    Ui::MainWindow *ui;

};

#endif