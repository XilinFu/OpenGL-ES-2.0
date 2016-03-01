//
//  GLSL.h
//  UtoVRPlayer
//
//  Created by administrator on 12/15/15.
//  Copyright © 2015 xue. All rights reserved.
//

#ifndef GLSL_h
#define GLSL_h

#define VertexShaderString "\
attribute vec4 a_position;\
attribute vec2 a_textureCoord;\
\
uniform bool isLeft;\
uniform bool is180DegreeVideo;\
uniform float leftUScale;\
uniform float leftUOffset;\
uniform float leftVScale;\
uniform float leftVOffset;\
uniform float rightUScale;\
uniform float rightUOffset;\
uniform float rightVScale;\
uniform float rightVOffset;\
uniform mat4 u_modelViewProjectionMatrix;\
\
varying lowp vec2 v_texCoord;\
\
void main()\
{\
float s = a_textureCoord.s;\
if (is180DegreeVideo) {\
if (s < 0.5) {\
s *= 2.0;\
} else {\
s = 1.0 - s;\
s *= 2.0;\
}\
}\
if (isLeft) {\
v_texCoord = vec2(s * leftUScale + leftUOffset, (1.0 - a_textureCoord.t) * leftVScale + leftVOffset);\
} else {\
v_texCoord = vec2(s * rightUScale + rightUOffset, (1.0 - a_textureCoord.t) * rightVScale + rightVOffset);\
}\
gl_Position = u_modelViewProjectionMatrix * a_position;\
}\
"

#define FragmentVideoShaderString "\
varying lowp vec2 v_texCoord;\
precision mediump float;\
\
uniform sampler2D SamplerUV;\
uniform sampler2D SamplerY;\
uniform mat3 colorConversionMatrix;\
\
void main()\
{\
mediump vec3 yuv;\
lowp vec3 rgb;\
\
yuv.x = (texture2D(SamplerY, v_texCoord).r - (16.0/255.0));\
yuv.yz = (texture2D(SamplerUV, v_texCoord).ra - vec2(0.5, 0.5));\
\
rgb =   yuv*colorConversionMatrix;\
\
gl_FragColor = vec4(rgb,1);\
\
}\
"

#define HotspotVertexShaderString @"\
attribute vec2 xyPosition;\
void main() {\
    gl_Position = vec4(xyPosition, 1, 1);\
}\
"

#define HotspotFragShaderString @"\
void main() {\
gl_FragColor = vec4(0,1,1,1);\
}\
"
#endif /* GLSL_h */
