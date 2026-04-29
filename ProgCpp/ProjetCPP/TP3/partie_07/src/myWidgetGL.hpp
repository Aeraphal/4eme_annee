#pragma once
#ifndef MY_WIDGET_GL_H
#define MY_WIDGET_GL_H

#include <GL/glew.h>
#include <GL/gl.h>

#include <QtOpenGL/QGLWidget>


class myWidgetGL : public QGLWidget
{
    Q_OBJECT
public:
    myWidgetGL(QGLFormat const& format,QGLWidget *parent = nullptr);
    ~myWidgetGL();


    void draw();
    void wireframe(bool is_activated);

protected:

    void initializeGL();
    void paintGL();

private:

    GLuint shader_program_id;
    GLuint vbo;

    bool state_drawing;

};

#endif
