
#include "render_area.hpp"

#include <iostream>

#include <QPixmap>
#include <QPainter>

render_area::render_area(QWidget *parent)
    :QWidget(parent),pixmap(new QPixmap),draw_circle(true)
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
    brush.setColor(Qt::gray); //color of the interior of the shape
    brush.setStyle(Qt::SolidPattern); //fill the interior
    painter.setBrush(brush);

    //if draw_circle is true, then we draw an ellipsoid
    if(draw_circle)
        painter.drawEllipse(200,100,200,100);

}


void render_area::change_draw_circle_state()
{
    draw_circle=!draw_circle;
    repaint();
}
