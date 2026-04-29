#pragma once

#ifndef RENDER_AREA_HPP
#define RENDER_AREA_HPP

#include <QWidget>

//Forward declaration of QPixmap
class QPixmap;

/** Declaration of render_area class */
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

private:

	/** A QPixmap is an image */
    QPixmap *pixmap;
    /** A boolean indicating if a circle should be drawn or not */
    bool draw_circle;


};

#endif
