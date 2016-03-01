//
//  HelloDot.m
//  ModernGL
//
//  Created by administrator on 16/3/1.
//  Copyright © 2016年 xue. All rights reserved.
//

#import "HelloDot.h"
#import <OpenGLES/ES2/gl.h>

GLfloat vertices[] = {
    0,0,0,1,0,0,1,
    0,1,0,1,0,0,1,
    1,0,0,1,0,0,1
};

@interface HelloDot ()
@property (nonatomic,assign) GLuint VBO;
@end

@implementation HelloDot

-(void)viewDidLoad {
    [super viewDidLoad];
    
    EAGLContext *ct = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    ((GLKView*)self.view).context = ct;
    [EAGLContext setCurrentContext:ct];
    
    glClearColor(0, 0, 0, 1);

    glGenBuffers(1, &_VBO);
    glBindBuffer(GL_ARRAY_BUFFER, self.VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT);
    
    glBindBuffer(GL_ARRAY_BUFFER, self.VBO);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 28, NULL);
    
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 28, sizeof(GL_FLOAT) * 3 + NULL);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}

@end
