#include "window.hpp"
#include "render_area.hpp"

#include "ui_mainwindow.h"

#include <iostream>

window::window(QWidget *parent)
    :QMainWindow(parent),ui(new Ui::MainWindow),render(new render_area)
{
    //setup the graphical interface to the current widget
    ui->setupUi(this);

    //Attach the render_area window to the widget
    ui->layout_scene->addWidget(render);

    //connect signals
    connect(ui->quit,SIGNAL(clicked()),this,SLOT(action_quit()));
    connect(ui->draw,SIGNAL(clicked()),this,SLOT(action_draw()));
}


window::~window()
{

}

void window::action_quit()
{
    close();
}

void window::action_draw()
{
    render->change_draw_circle_state();
}
