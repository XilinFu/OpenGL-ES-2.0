//
//  Shader.fsh
//  AppleGame
//
//  Created by administrator on 16/3/1.
//  Copyright © 2016年 xue. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
