#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <GL/glew.h>

#include <glfw3.h>
GLFWwindow* window;

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
using namespace glm;

#include <common/shader.hpp>

float randColor();

int main( void )
{
	// Initialise GLFW
	if( !glfwInit() )
	{
		fprintf( stderr, "Failed to initialize GLFW\n" );
		getchar();
		return -1;
	}

    glfwWindowHint(GLFW_SAMPLES, 4);
	glfwWindowHint(GLFW_RESIZABLE,GL_FALSE);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1);


    // Open a window and create its OpenGL context
	window = glfwCreateWindow( 1024, 768, "Playground", NULL, NULL);
	if( window == NULL ){
		fprintf( stderr, "Failed to open GLFW window. If you have an Intel GPU, they are not 3.3 compatible. Try the 2.1 version of the tutorials.\n" );
		getchar();
		glfwTerminate();
		return -1;
	}
	glfwMakeContextCurrent(window);

	// Initialize GLEW
	if (glewInit() != GLEW_OK) {
		fprintf(stderr, "Failed to initialize GLEW\n");
		getchar();
		glfwTerminate();
		return -1;
	}

    static const GLfloat vertices[] = {
        -1.0f,-1.0f,-1.0f,
        -1.0f,-1.0f, 1.0f,
        -1.0f, 1.0f, 1.0f,
        1.0f, 1.0f,-1.0f,
        -1.0f,-1.0f,-1.0f,
        -1.0f, 1.0f,-1.0f,
        1.0f,-1.0f, 1.0f,
        -1.0f,-1.0f,-1.0f,
        1.0f,-1.0f,-1.0f,
        1.0f, 1.0f,-1.0f,
        1.0f,-1.0f,-1.0f,
        -1.0f,-1.0f,-1.0f,
        -1.0f,-1.0f,-1.0f,
        -1.0f, 1.0f, 1.0f,
        -1.0f, 1.0f,-1.0f,
        1.0f,-1.0f, 1.0f,
        -1.0f,-1.0f, 1.0f,
        -1.0f,-1.0f,-1.0f,
        -1.0f, 1.0f, 1.0f,
        -1.0f,-1.0f, 1.0f,
        1.0f,-1.0f, 1.0f,
        1.0f, 1.0f, 1.0f,
        1.0f,-1.0f,-1.0f,
        1.0f, 1.0f,-1.0f,
        1.0f,-1.0f,-1.0f,
        1.0f, 1.0f, 1.0f,
        1.0f,-1.0f, 1.0f,
        1.0f, 1.0f, 1.0f,
        1.0f, 1.0f,-1.0f,
        -1.0f, 1.0f,-1.0f,
        1.0f, 1.0f, 1.0f,
        -1.0f, 1.0f,-1.0f,
        -1.0f, 1.0f, 1.0f,
        1.0f, 1.0f, 1.0f,
        -1.0f, 1.0f, 1.0f,
        1.0f,-1.0f, 1.0f
    };
    static GLfloat colors[] = {
        0.583f,  0.771f,  0.014f,
        0.609f,  0.115f,  0.436f,
        0.327f,  0.483f,  0.844f,
        0.822f,  0.569f,  0.201f,
        0.435f,  0.602f,  0.223f,
        0.310f,  0.747f,  0.185f,
        0.597f,  0.770f,  0.761f,
        0.559f,  0.436f,  0.730f,
        0.359f,  0.583f,  0.152f,
        0.483f,  0.596f,  0.789f,
        0.559f,  0.861f,  0.639f,
        0.195f,  0.548f,  0.859f,
        0.014f,  0.184f,  0.576f,
        0.771f,  0.328f,  0.970f,
        0.406f,  0.615f,  0.116f,
        0.676f,  0.977f,  0.133f,
        0.971f,  0.572f,  0.833f,
        0.140f,  0.616f,  0.489f,
        0.997f,  0.513f,  0.064f,
        0.945f,  0.719f,  0.592f,
        0.543f,  0.021f,  0.978f,
        0.279f,  0.317f,  0.505f,
        0.167f,  0.620f,  0.077f,
        0.347f,  0.857f,  0.137f,
        0.055f,  0.953f,  0.042f,
        0.714f,  0.505f,  0.345f,
        0.783f,  0.290f,  0.734f,
        0.722f,  0.645f,  0.174f,
        0.302f,  0.455f,  0.848f,
        0.225f,  0.587f,  0.040f,
        0.517f,  0.713f,  0.338f,
        0.053f,  0.959f,  0.120f,
        0.393f,  0.621f,  0.362f,
        0.673f,  0.211f,  0.457f,
        0.820f,  0.883f,  0.371f,
        0.982f,  0.099f,  0.879f
    };
    
    static GLfloat g_color_buffer_data[12*3*3];
    

    
    GLuint verticesVBO;
    glGenBuffers(1,&verticesVBO);
    glBindBuffer(GL_ARRAY_BUFFER,verticesVBO);
    glBufferData(GL_ARRAY_BUFFER,sizeof(vertices),vertices,GL_STATIC_DRAW);
    
    GLuint colorVBO;
    glGenBuffers(1,&colorVBO);
    glBindBuffer(GL_ARRAY_BUFFER,colorVBO);
    
	// Ensure we can capture the escape key being pressed below
	glfwSetInputMode(window, GLFW_STICKY_KEYS, GL_TRUE);
//
//	// Dark blue background
	glClearColor(0.0f, 0.0f, 0.4f, 0.0f);
//
    GLuint programID = LoadShaders("Vertex.glsl", "Fragment.glsl");
    GLuint locationIndex = glGetAttribLocation(programID,"vertex");
    GLuint mvpIndex = glGetUniformLocation(programID,"mvp");
    GLuint colorIndex = glGetAttribLocation(programID,"color");
    
    do{
		// Draw nothing, see you in tutorial 2 !
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUseProgram(programID);
        
        for (int v = 0; v < 12 * 3; v++) {
            srand((unsigned) time(NULL) + v);
            
            g_color_buffer_data[3*v + 0] = randColor();

            g_color_buffer_data[3*v + 1] = randColor();

            g_color_buffer_data[3*v + 2] = randColor();
            
        }
        
        // rotate
        glBindBuffer(GL_ARRAY_BUFFER,verticesVBO);
        glEnableVertexAttribArray(locationIndex);
        glVertexAttribPointer(locationIndex,3,GL_FLOAT,GL_FALSE,sizeof(GL_FLOAT) * 3, NULL);
        glBindBuffer(GL_ARRAY_BUFFER,0);
        
        glBindBuffer(GL_ARRAY_BUFFER,colorVBO);
        glEnableVertexAttribArray(colorIndex);
        glBufferData(GL_ARRAY_BUFFER,sizeof(g_color_buffer_data),g_color_buffer_data,GL_STATIC_DRAW);

        glVertexAttribPointer(colorIndex,3,GL_FLOAT,GL_FALSE,sizeof(GL_FLOAT) * 3 , NULL);
        glBindBuffer(GL_ARRAY_BUFFER,0);
        
        glEnable(GL_DEPTH_TEST);
        glDepthFunc(GL_LESS);
        
        glm::mat4 M = glm::mat4(1);
        glm::mat4 V = glm::lookAt(
                                  glm::vec3(4,3,-3),
                                  glm::vec3(0,0,0),
                                  glm::vec3(0,1,0)
                                  );
        glm::mat4 P = glm::perspective(45.0f, 4.0f / 3.0f, 0.1f, 100.0f);
        glm::mat4 mvp = P * V * M;
        glUniformMatrix4fv(mvpIndex,1,GL_FALSE,&mvp[0][0]);
        
        glDrawArrays(GL_TRIANGLES, 0, 12 * 3);
        
        glDisable(GL_DEPTH_TEST);
        glUseProgram(0);
        // Swap buffers
		glfwSwapBuffers(window);
		glfwPollEvents();

    } // Check if the ESC key was pressed or the window was closed
	while( glfwGetKey(window, GLFW_KEY_ESCAPE ) != GLFW_PRESS &&
		   glfwWindowShouldClose(window) == 0 );

    // Close OpenGL window and terminate GLFW
    glfwTerminate();

    return 0;
}

float randColor() {
    int r = rand() ;
    r %= 255;
    float rf = (float)r;
    rf /= 255.0;
    return rf;
}

