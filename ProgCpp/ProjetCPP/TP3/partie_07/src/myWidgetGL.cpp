#include "myWidgetGL.hpp"

#include <GL/glu.h>
#include "glutils.hpp"

#include <iostream>

myWidgetGL::myWidgetGL(QGLFormat const& format,QGLWidget *parent) :
    QGLWidget(format,parent),shader_program_id(0),vbo(0),state_drawing(true)
{}

myWidgetGL::~myWidgetGL()
{}

void myWidgetGL::initializeGL()
{
    std::cout<<"call myWidgetGL::initializeGL()"<<std::endl;

    glewInit();
    float vertices[]={0,0,0,
                     0.5,0,0,
                     0,1,0};

    glClearColor(0.0, 1.0, 1.0, 0.0);
    glEnable(GL_DEPTH_TEST);

    //generate a VBO
    glGenBuffers(1,&vbo); PRINT_OPENGL_ERROR();
    //Set VBO to current state
    glBindBuffer(GL_ARRAY_BUFFER,vbo); PRINT_OPENGL_ERROR();
    //Copy data to GPU
    glBufferData(GL_ARRAY_BUFFER,sizeof(vertices),vertices,GL_STATIC_DRAW); PRINT_OPENGL_ERROR();

    // Load shaders
    shader_program_id = read_shader("shader.vert", "shader.frag");

    //activate depth test
    glEnable(GL_DEPTH_TEST); PRINT_OPENGL_ERROR();
}




void myWidgetGL::paintGL()
{
    //set background color
    glClearColor(0.5, 0.6, 0.9, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    if(state_drawing==true)
    {
        //set current VBO
        glBindBuffer(GL_ARRAY_BUFFER,vbo); PRINT_OPENGL_ERROR();
        //activate vertex data
        glEnableClientState(GL_VERTEX_ARRAY); PRINT_OPENGL_ERROR();
        //setup current vertex pointer on the vbo
        glVertexPointer(3, GL_FLOAT, 0, 0); PRINT_OPENGL_ERROR();

        //Drawing call
        glDrawArrays(GL_TRIANGLES, 0, 3); PRINT_OPENGL_ERROR();
    }
}



void myWidgetGL::draw()
{
    state_drawing=!state_drawing;
    std::cout<<"Drawing state = "<<state_drawing<<std::endl;

    updateGL();
}
void myWidgetGL::wireframe(bool is_activated)
{
    if(is_activated==true)
        glPolygonMode( GL_FRONT_AND_BACK, GL_LINE);
    else
        glPolygonMode( GL_FRONT_AND_BACK, GL_FILL);

    updateGL();
}
