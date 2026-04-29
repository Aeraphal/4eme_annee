#pragma once
#ifndef MY_WINDOW_HPP
#define MY_WINDOW_HPP

#include <QMainWindow>

//Forward declaration
namespace Ui{
class MainWindow;
}
class myWidgetGL;

/**
 * Declaration of the Window class
 */
class myWindow: public QMainWindow
{
    Q_OBJECT

public:

    myWindow(QWidget *parent=nullptr);
    ~myWindow();

private slots:

    void action_quit();
    void action_draw();
    void action_wireframe();

private:

    Ui::MainWindow *ui;
    myWidgetGL *glWidget;
};

#endif
