//
//  ViewController.m
//  CubeAnimation
//
//  Created by Loveway on 15/8/7.
//  Copyright (c) 2015年 Henry·Cheng. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import "CATransformHelper.h"

@interface ViewController ()<UIGestureRecognizerDelegate>{
    
    UIView      *_bgView;
    UIImageView *_imgView1;
    UIImageView *_imgView2;
    UIImageView *_imgView3;
    UIImageView *_imgView4;
    UIImageView *_imgView5;
    UIImageView *_imgView6;
    NSArray *_cubeArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bgView = [[UIView alloc]init];
//    bgView.backgroundColor = [UIColor greenColor];
    _bgView.layer.contentsScale = [UIScreen mainScreen].scale;
    _bgView.bounds = CGRectMake(0, 0, 200, 200);
    _bgView.layer.position = self.view.center;
    _bgView.userInteractionEnabled = YES;
    
    CATransform3D transform = CATransform3DIdentity;
    //在X轴上做一个10度的小旋转
    transform = CATransform3DRotate(transform, -M_PI /18, 1, 1, 0);
    transform.m34 = -1.0 / 2000;
    //设置CALayer的sublayerTransform
    _bgView.layer.sublayerTransform = transform;
    
    //添加Layer
    [self.view.layer addSublayer:_bgView.layer];
    [self.view addSubview:_bgView];
    [self creatImageView];
    
     [self performSelector:@selector(cubeAnimate) withObject:self afterDelay:0.1];
    [_bgView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)]];


}

//魔方动画
- (void)cubeAnimate {
    CATransform3D t;
    t=CATransform3DIdentity;
    CABasicAnimation *cubeanima = [CABasicAnimation animationWithKeyPath:@"sublayerTransform"];
    cubeanima.duration = 0.1;
    cubeanima.autoreverses = NO;
    cubeanima.fillMode = kCAFillModeBoth;
    cubeanima.removedOnCompletion = NO;
    cubeanima.delegate = self;
    if (_bgView.layer != nil) {
        _bgView.layer.sublayerTransform = t;
    }
    [_bgView.layer addAnimation:cubeanima forKey:@"cubeanima"];
}


- (void)creatImageView {

     _imgView1 = [[UIImageView alloc]init];
     _imgView2 = [[UIImageView alloc]init];
     _imgView3 = [[UIImageView alloc]init];
     _imgView4 = [[UIImageView alloc]init];
     _imgView5 = [[UIImageView alloc]init];
     _imgView6 = [[UIImageView alloc]init];
    
     _cubeArr = @[_imgView1,_imgView2,_imgView3,_imgView4,_imgView5,_imgView6];
   
    for (int i = 0;i < _cubeArr.count;i ++) {
        
        UIImageView *imageView = _cubeArr[i];
        imageView.tag = i + 1;
        imageView.layer.contentsScale = [UIScreen mainScreen].scale;
        imageView.bounds = CGRectMake(0, 0, 200, 200);
        imageView.layer.position = CGPointMake(CGRectGetMidX(_bgView.bounds), CGRectGetMidY(_bgView.bounds));
        
        if (i == 0) {
            
            CATransform3D transform = CATransform3DMakeTranslation(0, 0, 200/2.);
            transform = CATransform3DRotate(transform,0, 0,0, 0);
            //设置transform属性并把Layer加入到主Layer中
            imageView.layer.transform = transform;
            imageView.backgroundColor = [UIColor redColor];
            if (transform.m43 > 0) {
                imageView.userInteractionEnabled=YES;
            }
        } else if (i == 1) {
            //上
            CATransform3D transform = CATransform3DMakeTranslation(0, -200/2., 0);
            transform = CATransform3DRotate(transform,-M_PI_2, 1,0, 0);
            transform = CATransform3DRotate(transform, M_PI, 0, 0, 1);
            transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
            //设置transform属性并把Layer加入到主Layer中
            imageView.layer.transform = transform;
            imageView.backgroundColor = [UIColor greenColor];

        } else if (i == 2) {
            //下
            CATransform3D transform = CATransform3DMakeTranslation(0, 200/2., 0);
            transform = CATransform3DRotate(transform,M_PI_2, 1,0, 0);
            transform = CATransform3DRotate(transform, M_PI, 0, 0, 1);
            transform=  CATransform3DRotate(transform, M_PI, 0, 1, 0);
            //设置transform属性并把Layer加入到主Layer中
            imageView.layer.transform = transform;
            imageView.backgroundColor = [UIColor cyanColor];

        } else if (i == 3) {
            //左
            CATransform3D transform = CATransform3DMakeTranslation(-200/2., 0, 0);
            transform = CATransform3DRotate(transform,-M_PI_2, 0,1, 0);
            //设置transform属性并把Layer加入到主Layer中
            imageView.layer.transform = transform;
            imageView.backgroundColor = [UIColor grayColor];

        } else if (i == 4) {
            //右
            CATransform3D transform = CATransform3DMakeTranslation(200/2., 0, 0);
            transform = CATransform3DRotate(transform,M_PI_2, 0,1, 0);
            //设置transform属性并把Layer加入到主Layer中
            imageView.layer.transform = transform;
            imageView.backgroundColor = [UIColor magentaColor];
        } else {
            //后
            CATransform3D transform = CATransform3DMakeTranslation(0, 0, -200/2.);
            transform = CATransform3DRotate(transform,0, 0,0, 0);
            transform = CATransform3DRotate(transform, M_PI, 0, 0, 1);
            transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
            //设置transform属性并把Layer加入到主Layer中
            imageView.layer.transform = transform;
            imageView.backgroundColor = [UIColor blackColor];

        }
               
           [_bgView.layer addSublayer:imageView.layer];
           UITapGestureRecognizer* cubeRecognizer;
           cubeRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCubeTapFrom:)];
           cubeRecognizer.numberOfTapsRequired = 1; // 单击
           cubeRecognizer.delegate = self;
           [imageView addGestureRecognizer:cubeRecognizer];

    }
    
}

- (void)handleGes:(UIPanGestureRecognizer *)ges {
    CGPoint diff = [ges translationInView:_bgView];
    float rotX = 1 * GLKMathDegreesToRadians(diff.y / 2.0);
    float rotY = -1 * GLKMathDegreesToRadians(diff.x / 2.0);
    if (_bgView.layer==nil)  {
        return;
    } else {
        CATransform3D t = _bgView.layer.sublayerTransform;
        t = CATransform3DRotate(t, -rotX, 1, 0, 0);
        t = CATransform3DRotate(t, -rotY, 0, 1, 0);
        _bgView.layer.sublayerTransform = t;
    }
    [ges setTranslation:CGPointZero inView:self.view];
    
    if(ges.state == UIGestureRecognizerStateEnded){
        
        //判断哪些面在前面
        CGFloat angleX = [CATransformHelper getXRotation:_bgView.layer.sublayerTransform]-M_PI_2;
        CGFloat angleY = [CATransformHelper getYRotation:_bgView.layer.sublayerTransform];
        CGFloat angleZ = [CATransformHelper getZRotation:_bgView.layer.sublayerTransform]-M_PI_2;
        
        NSMutableArray *mutArray = [NSMutableArray array];
        
        if(angleY <- M_PI_2 || angleY > M_PI_2){
            NSLog(@"5");
            [mutArray addObject:_imgView6];
        } else {
            NSLog(@"0");
            [mutArray addObject:_imgView1];
        }
        
        if(angleX < -M_PI_2 || angleX > M_PI_2){
            NSLog(@"1");
            [mutArray addObject:_imgView2];
        } else {
            NSLog(@"2");
            [mutArray addObject:_imgView3];
        }
        
        if(angleZ < -M_PI_2 || angleZ > M_PI_2){
            NSLog(@"4");
            [mutArray addObject:_imgView5];
        } else {
            NSLog(@"3");
            [mutArray addObject:_imgView4];
        }
        
        //计算面积并且排序
        NSArray *sortArray = [mutArray sortedArrayUsingComparator:^NSComparisonResult(UIView * obj1, UIView *obj2) {
            CGFloat s1 = [self getViewArea:obj1];
            CGFloat s2 = [self getViewArea:obj2];
            
            if(s1>s2){
                return NSOrderedAscending;
            } else if (s1<s2) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        }];
        
        UIView *targetView = [sortArray firstObject];
        targetView.userInteractionEnabled = YES;
        
        NSLog(@"目标对象：%d",(int)targetView.tag);
        NSInteger tag = targetView.tag;
        
//        imageIndex=tag;
        CATransform3D t;
        if(tag==1){//前
            t=CATransform3DIdentity;
        } else if (tag == 2) {//上
            t=CATransform3DMakeRotation(-M_PI_2, 1,0, 0);
        } else if (tag == 3) {//下
            t=CATransform3DMakeRotation(M_PI_2, 1,0, 0);
        } else if (tag == 4) {//左
            t=CATransform3DMakeRotation(M_PI_2, 0,1, 0);
        } else if (tag == 5) {//右
            t=CATransform3DMakeRotation(-M_PI_2, 0,1, 0);
        } else if (tag == 6) {//后
            t=CATransform3DMakeRotation(M_PI, 1,0, 0);
        }

            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"sublayerTransform"];
            animation.duration = 0.3;
            animation.autoreverses = NO;
            animation.removedOnCompletion = NO;
            animation.delegate = self;
            animation.fillMode = kCAFillModeForwards;
            _bgView.layer.sublayerTransform = t;
            [_bgView.layer addAnimation:animation forKey:@"ani"];

    }
}
//获取某个视图的面积
- (CGFloat)getViewArea:(UIView *)view {
    CGFloat width = 200;
    //判断屏幕前需要暂停的方块
    CGPoint p1 = [view convertPoint:CGPointMake(0, 0) toView:self.view];
    CGPoint p2 = [view convertPoint:CGPointMake(width, 0) toView:self.view];
    CGPoint p3 = [view convertPoint:CGPointMake(0, width) toView:self.view];
    
    //获取边长
    CGFloat a = pow(pow(p1.x-p3.x, 2)+pow(p1.y-p3.y, 2), 0.5);
    CGFloat b = pow(pow(p1.x-p2.x, 2)+pow(p1.y-p2.y, 2), 0.5);
    CGFloat c = pow(pow(p3.x-p2.x, 2)+pow(p3.y-p2.y, 2), 0.5);
    CGFloat p = (a+b+c)/2;
    //计算高度
    CGFloat h = 2*sqrt(p*(p-a)*(p-b)*(p-c))/b;
    CGFloat S = b*h;
    return S;
}

//魔方点击事件
- (void)handleCubeTapFrom:(UITapGestureRecognizer *)tap {
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
