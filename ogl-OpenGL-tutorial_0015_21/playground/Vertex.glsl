#version 120
attribute vec3 vertex;
attribute vec3 color;
uniform mat4 mvp;

varying vec3 fragmentColor;

void main() {
    gl_Position = mvp * vec4(vertex,1);
    
    fragmentColor = color;
}