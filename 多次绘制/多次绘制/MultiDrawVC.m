//
//  MultiDrawVC.m
//  多次绘制
//
//  Created by administrator on 16/3/1.
//  Copyright © 2016年 xue. All rights reserved.
//

#import "MultiDrawVC.h"
#import "GLSL.h"
#import <OpenGLES/ES2/glext.h>

@interface MultiDrawVC ()
@property (nonatomic,assign) GLuint hotspotProgram;
@property (nonatomic,assign) GLuint hotspotVAOID;
@end

@implementation MultiDrawVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    GLKView *gView = self.view;
    gView.context =[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:gView.context];
    
    [self loadHotspotShaders];
    
    glGenVertexArraysOES(1, &_hotspotVAOID);
    glBindVertexArrayOES(_hotspotVAOID);
    
    float hotspotVertices[] = {
        0.5,0.5,
        -0,0.5,
        -0,-0.5,
        0.5,-0.5
    };
    
    GLuint hotspotVertexBuffer;
    glGenBuffers(1, &hotspotVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, hotspotVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * 2 * 4, hotspotVertices, GL_STATIC_DRAW);
    GLuint hotspotVertexIndex = glGetAttribLocation(self.hotspotProgram, "xyPosition");
    glEnableVertexAttribArray(hotspotVertexIndex);
    glVertexAttribPointer(hotspotVertexIndex, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 2, NULL);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArrayOES(0);

    
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [super glkView:view drawInRect:rect];
    
    glClearColor(0.2, 0.2, 0.2, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glBindVertexArrayOES(self.hotspotVAOID);
    glDrawArrays(GL_TRIANGLES, 0, 2);
}

- (BOOL)loadHotspotShaders
{
    GLuint vertShader, fragShader;
    
    // Create the shader program.
    self.hotspotProgram = glCreateProgram();
    // Create and compile the vertex shader.
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER glslString:HotspotVertexShaderString]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    // Create and compile fragment shader.
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER glslString:HotspotFragShaderString]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(self.hotspotProgram, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(self.hotspotProgram, fragShader);
    
    // Bind attribute locations. This needs to be done prior to linking.
    //    glBindAttribLocation(self.program, ATTRIB_VERTEX, "a_position");
    //    glBindAttribLocation(self.program, ATTRIB_TEXCOORD, "a_textureCoord");
    
    // Link the program.
    if (![self linkProgram:self.hotspotProgram]) {
        NSLog(@"Failed to link program: %d", self.hotspotProgram);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (self.hotspotProgram) {
            glDeleteProgram(self.hotspotProgram);
            self.hotspotProgram = 0;
        }
        
        return NO;
    }
    
    // Get uniform locations.
    //    uniforms[UNIFORM_HOTSPOT_MVP] = glGetUniformLocation(self.hotspotProgram, "mvp");
    
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(self.hotspotProgram, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(self.hotspotProgram, fragShader);
        glDeleteShader(fragShader);
    }
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type glslString:(NSString *)content
{
    NSError *error;
    if (content == nil) {
        NSLog(@"Failed to load vertex shader: %@", [error localizedDescription]);
        return NO;
    }
    
    GLint status;
    const GLchar *source;
    source = (GLchar *)[content UTF8String];
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}
@end
