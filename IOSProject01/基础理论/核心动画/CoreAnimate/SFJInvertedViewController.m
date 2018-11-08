//
//  SFJInvertedViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/20.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJInvertedViewController.h"

@interface SFJInvertedViewController ()
@property(nonatomic , strong)UIView *RepView;
@end

@implementation SFJInvertedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _RepView = [[UIView alloc]initWithFrame:CGRectMake(16, 90, 130, 130)];
    _RepView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_RepView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CATransition4"]];
    imgView.frame = CGRectMake(0, 0, 130, 130);
    //imgView.contentMode = UIViewContentModeScaleAspectFit;
    [_RepView addSubview:imgView];
    
    CAReplicatorLayer *repL = [CAReplicatorLayer layer];
  //   CAReplicatorLayer *layer = (CAReplicatorLayer *)_RepView.layer;
    repL.instanceCount = 2;
    repL.frame = _RepView.bounds;
    
    
    //生成倒影
    CATransform3D transform = CATransform3DMakeTranslation(0, _RepView.height, 0); //先向下平移
    transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);  // 再绕X轴旋转180
   // transform = CATransform3DInvert(transform);  // 反转
    repL.instanceTransform = transform;
    
    repL.instanceAlphaOffset = -0.1;
    repL.instanceBlueOffset = -0.1;
    repL.instanceGreenOffset = -0.1;
    repL.instanceRedOffset = -0.1;
    
//    CALayer *layer = [CALayer layer];
//    layer.frame = _RepView.frame;
//    [repL addSublayer:layer];
    
    [self.view.layer addSublayer:repL];
    
}

@end
