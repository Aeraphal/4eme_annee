
#pragma once

#ifndef WINDOW_HPP
#define WINDOW_HPP

#include <QMainWindow>

//Forward declaration of Ui::mainWindow and render_area
namespace Ui{
class MainWindow;
}
class render_area;

//Declaraction of the class Window
class window: public QMainWindow
{
    Q_OBJECT

public:

    window(QWidget *parent=nullptr);
    ~window();

private slots:

    void action_quit();
    void action_draw();

private:

    Ui::MainWindow *ui;
    render_area *render;
};

#endif