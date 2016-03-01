//
//  ShowAWindowVC.m
//  ModernGL
//
//  Created by administrator on 16/3/1.
//  Copyright © 2016年 xue. All rights reserved.
//

#import "ShowAWindowVC.h"

@implementation ShowAWindowVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    EAGLContext *ct = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    ((GLKView*)self.view).context = ct;
    [EAGLContext setCurrentContext:ct];
    
    [self.view setNeedsDisplay];
}
//-(void)update {
//    glClearColor(0, 1, 0, 1);
//    glClear(GL_COLOR_BUFFER_BIT);
//}
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [super glkView:view drawInRect:rect];
    
    glClearColor(0, 1, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
}

@end
