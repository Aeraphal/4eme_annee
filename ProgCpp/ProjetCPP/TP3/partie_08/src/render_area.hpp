#pragma once

#ifndef RENDER_AREA_HPP
#define RENDER_AREA_HPP

#include "circle.hpp"

#include <QWidget>
#include <QTimer>
#include <QTime>
#include <list>

//forward declaration of QLabel
class QLabel;



class render_area : public QWidget
{
    Q_OBJECT
public:

    render_area(QWidget *parent = 0);
    ~render_area();

    /** Draw or not the circle when called */
    void change_draw_circle_state();

protected:
    /** Actual drawing function */
    void paintEvent(QPaintEvent *event);

private slots:

    /** Function called periodically at constant time interval by a timer */
    void update_timer();

private: //functions

    /** Move forward in time */
    void numerical_integration();

    /** Deal with collision */
    vec2 collision_handling(vec2& p);

private: //attributes

    /** The circle */
    circle circ;
    /** The speed of the circle */
    vec2 speed;
    /** The time integration step */
    float dt;

    /** Indicates if the circle should be drawn */
    bool draw_circle;

    /** Timer for periodic time iteration */
    QTimer timer;

};

#endif
