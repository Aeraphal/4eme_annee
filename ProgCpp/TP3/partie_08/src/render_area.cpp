
#include "render_area.hpp"

#include <QPainter>
#include <QMouseEvent>
#include <QLabel>

#include <iostream>

render_area::render_area(QWidget *parent)
    :QWidget(parent),
      circ({200,150},25),
      speed(35.0f,-50.0f),
      dt(1/5.0f),
      draw_circle(true),
      timer()
{
    setBackgroundRole(QPalette::Base);
    setAutoFillBackground(true);

    //timer calling the function update_timer periodicaly
    connect(&timer, SIGNAL(timeout()), this, SLOT(update_timer()));
    timer.start(30); //every 30ms
}

render_area::~render_area()
{}



void render_area::paintEvent(QPaintEvent*)
{
    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing, true);

    QPen pen;
    pen.setWidth(1.0);
    pen.setColor(Qt::blue);
    painter.setPen(pen);

    QBrush brush = painter.brush();
    brush.setColor(Qt::gray);
    brush.setStyle(Qt::SolidPattern);
    painter.setBrush(brush);

    if(draw_circle)
    {
        //the actual drawing of the circle
        vec2 const& p = circ.center;
        float const r = circ.radius;
        
        painter.drawEllipse(p.x-r,p.y-r,2*r,2*r);
    }
}


void render_area::update_timer()
{
    //called periodically
    numerical_integration();

    repaint();
}

void render_area::numerical_integration()
{
    //numerical integration using Forward Euler method
    //*************************************************//

    float const damping = 0.02f;        //deceleration force
    vec2  const gravity = {0.0f,9.81f}; //gravity force
    
    vec2& p=circ.center;

    //Solve Sum(forces)=mass*acceleration (with mass=1)
    speed = speed + dt*gravity;       //integrate speed
    speed = speed - dt*damping*speed; //apply damping (~friction force)
    p     = p+dt*speed;               //integrate position

    //collision handling (set new position, and return a new speed value)
    speed=collision_handling(p);
}

vec2 render_area::collision_handling(vec2& p)
{
    vec2 new_speed=speed;

    //size of the window
    float const h = height();
    float const w = width();

    //radius of the sphere
    float const r = circ.radius;

    //collision with the ground
    if( p.y+r>h )
    {
        p.y=h-r;
        new_speed.y *= -1;
    }
    //collision with the left wall
    if( p.x-r<0 )
    {
        p.x=r;
        new_speed.x *= -1;
    }
    //collision with the right wall
    if( p.x+r>w )
    {
        p.x=w-r;
        new_speed.x *= -1;
    }
    //collision with the top wall
    if( p.y-r<0 )
    {
        p.y=r;
        new_speed.y *= -1;
    }



    return new_speed;

}


void render_area::change_draw_circle_state()
{
    draw_circle=!draw_circle;
}
