#pragma once

#ifndef RENDER_AREA_HPP
#define RENDER_AREA_HPP

#include <QWidget>

//forward declaration of QPixmap
class QPixmap;

/** Declaration of render_area class
    This class enable to move a circle on the screen
     using the mouse.
    The circle follows the mouse when the cursor meet
     the circle.
*/
class render_area : public QWidget
{
    Q_OBJECT
public:
    render_area(QWidget *parent = nullptr);
    ~render_area();

    /** Inverse the state of the draw_circle variable
        Draw or not the ellipsoid */
    void change_draw_circle_state();

protected:
    /** The actual painting function */
    void paintEvent(QPaintEvent *event);
    /** Function called when the mouse is pressed */
    void mousePressEvent(QMouseEvent *event);
    /** Function called when the mouse is moved */
    void mouseMoveEvent(QMouseEvent *event);

private:

    /** A QPixmap is an image */
    QPixmap *pixmap;
    /** A boolean indicating if a circle should be drawn or not */
    bool draw_circle;

    /** Storage for the previous position of the mouse */
    int x_old,y_old;
    /** Current parameter of the circle
     *  \note (xc,yc) are the top left corner of the circle */
    int xc,yc,diameter;

};

#endif
