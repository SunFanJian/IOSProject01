//
//  SFJCAAnimationGroupViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJCAAnimationGroupViewController.h"

@interface SFJCAAnimationGroupViewController ()

@end

@implementation SFJCAAnimationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *scale = [CABasicAnimation animation]; // 缩放
    scale.keyPath = @"transform.scale";
    scale.toValue = @0.5;   // 对于不同的动画类型，结束时的值的类型也不一样
    
    CABasicAnimation *rotation = [CABasicAnimation animation];  // 旋转
    rotation.keyPath = @"transform.rotation";
    rotation.toValue = @(arc4random_uniform(M_PI));
    
    CABasicAnimation *position = [CABasicAnimation animation];  //移动
    position.keyPath = @"position";
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(200), arc4random_uniform(200))];
    
    group.animations = @[scale , rotation , position];
    [self.redView.layer addAnimation:group forKey:nil];
    
}
@end
