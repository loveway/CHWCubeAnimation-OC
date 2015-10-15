//
//  CATransformHelper.m
//  CubeAnimation
//
//  Created by HenryCheng on 15/10/15.
//  Copyright © 2015年 Henry·Cheng. All rights reserved.
//

#import "CATransformHelper.h"

@implementation CATransformHelper
+(CGFloat)getXRotation:(CATransform3D)t{
    return atan2(t.m23, t.m22);
}

+(CGFloat)getYRotation:(CATransform3D)t{
    return atan2(t.m31, t.m33);
}

+(CGFloat)getZRotation:(CATransform3D)t{
    return atan2(t.m12, t.m11);
}
@end
