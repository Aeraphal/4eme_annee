
#include "window.hpp"

#include "render_area.hpp"
#include "ui_mainwindow.h"

#include <iostream>

window::window(QWidget *parent)
    :QMainWindow(parent),ui(new Ui::MainWindow),render(new render_area)
{
    ui->setupUi(this);
    ui->layout_scene->addWidget(render);

    //Connection with signals
    connect(ui->quit,SIGNAL(clicked()),this,SLOT(action_quit()));
    connect(ui->draw,SIGNAL(clicked()),this,SLOT(action_draw()));

}


window::~window()
{}

void window::action_quit()
{
    close();
}

void window::action_draw()
{
    render->change_draw_circle_state();
}
