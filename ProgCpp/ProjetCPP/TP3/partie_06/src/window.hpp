#pragma once

#ifndef WINDOW_HPP
#define WINDOW_HPP

#include <QMainWindow>
#include <QtGui>
#include <QWidget>

//forward declaration
namespace Ui{
class MainWindow;
}
class render_area;

/** Window declaration */
class window: public QMainWindow
{
    Q_OBJECT

public:

    window(QWidget *parent=NULL);
    ~window();

private slots:

    void action_quit();
    void action_draw();

private:

    Ui::MainWindow *ui;
    render_area *render;

};

#endif
