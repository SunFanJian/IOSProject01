//
//  SFJVoiceLineViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/20.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJVoiceLineViewController.h"

@interface SFJVoiceLineViewController ()

@end

@implementation SFJVoiceLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redView.frame = CGRectMake(20, 150, 250, 300);
    self.redView.backgroundColor = [UIColor grayColor];
   
    // 创建复制图层
    CAReplicatorLayer *repL = [CAReplicatorLayer layer];
    repL.frame = self.redView.bounds;
    [self.redView.layer addSublayer:repL];
    
    // 创建子层
    CALayer *layer = [CALayer layer];
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(15, self.redView.bounds.size.height);
    layer.bounds = CGRectMake(0, 0, 30, 150);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [repL addSublayer:layer];
    
    //子层添加动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";  //y轴方向的缩放动画
    anim.toValue = @0.1;
    anim.duration = 0.5;
    anim.repeatCount = MAXFLOAT;
    anim.autoreverses = YES;    // 设置动画反转
    [layer addAnimation:anim forKey:nil];
    
    // 复制层中子层总数
    // instanceCount：表示复制层里面有多少个子层，包括原始层
    repL.instanceCount = 5;
    repL.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);     // 设置复制子层偏移量，不包括原始层,相对于原始层x偏移
    repL.instanceDelay = 0.1;        // 设置复制层动画延迟时间
    // 如果设置了原始层背景色，就不需要设置这个属性
    repL.instanceColor = [UIColor redColor].CGColor;
    repL.instanceGreenOffset = 0.3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
