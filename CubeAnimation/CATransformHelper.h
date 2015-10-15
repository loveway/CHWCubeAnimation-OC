//
//  CATransformHelper.h
//  CubeAnimation
//
//  Created by HenryCheng on 15/10/15.
//  Copyright © 2015年 Henry·Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface CATransformHelper : NSObject
/**
 *  获取X轴旋转角度
 *
 *  @param t
 *
 *  @return
 */
+(CGFloat)getXRotation:(CATransform3D)t;
/**
 *  获取Y轴旋转角度
 *
 *  @param t
 *
 *  @return
 */
+(CGFloat)getYRotation:(CATransform3D)t;
/**
 *  获取Z轴旋转角度
 *
 *  @param t
 *
 *  @return
 */
+(CGFloat)getZRotation:(CATransform3D)t;
@end
