
#include "render_area.hpp"

#include <iostream>

#include <QPixmap>
#include <QPainter>
#include <QMouseEvent>


render_area::render_area(QWidget *parent)
    :QWidget(parent),pixmap(new QPixmap),draw_circle(true),
      x_old(0),y_old(0),xc(200),yc(150),diameter(150)
{
    setBackgroundRole(QPalette::Base);
    setAutoFillBackground(true);
}

render_area::~render_area()
{
    if(pixmap!=nullptr)
    {
        delete pixmap;
        pixmap=nullptr;
    }
}

void render_area::paintEvent(QPaintEvent*)
{
    //A painter class able to draw in 2D
    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing, true);

    //The drawing pen with its properties
    QPen pen;
    pen.setWidth(4.0);
    pen.setColor(Qt::blue);
    painter.setPen(pen);

    //The brush class is usefull to fill the interior of the shapes
    QBrush brush = painter.brush();
    brush.setColor(Qt::gray);
    brush.setStyle(Qt::SolidPattern);
    painter.setBrush(brush);

    //if draw_circle is true, then we draw the specified circle
    if(draw_circle)
        painter.drawEllipse(xc,yc,diameter,diameter);


}

void render_area::change_draw_circle_state()
{
    draw_circle=!draw_circle;
    repaint();
}

void render_area::mousePressEvent(QMouseEvent *event)
{
    //when a click occurs, we store the current mouse position
    x_old=event->x();
    y_old=event->y();
}

void render_area::mouseMoveEvent(QMouseEvent *event)
{
    //get the current mouse position
    int x=event->x();
    int y=event->y();

    //compute the center of the circle
    int R=diameter/2.0f;
    int x0=xc+R;
    int y0=yc+R;

    //check if the current mouse position is within the circle
    if( (x-x0)*(x-x0)+(y-y0)*(y-y0)<R*R )
    {
        //translate the circle from the current displacement
        xc+=(x-x_old);
        yc+=(y-y_old);
    }

    //store the previous mouse position
    x_old=x;
    y_old=y;

    repaint();
}


