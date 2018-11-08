//
//  SFJHUDViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/20.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJHUDViewController.h"

@interface SFJHUDViewController ()

@end

@implementation SFJHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.redView.frame = CGRectMake(20, 100, 250, 250);
    self.redView.backgroundColor = [UIColor grayColor];
    
    // 创建复制图层
    CAReplicatorLayer *repL = [CAReplicatorLayer layer];
    repL.frame = self.redView.bounds;
    [self.redView.layer addSublayer:repL];
    
    //子层
    CALayer *layer = [CALayer layer];
    layer.transform = CATransform3DMakeScale(0,0,0);
    layer.position = CGPointMake(self.redView.width / 2, 20);
    layer.bounds = CGRectMake(0, 0, 10, 10);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.cornerRadius = 5;
    [repL addSublayer:layer];
    
    // 创建缩放动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.fromValue = @1;
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
     CGFloat duration = 1;
    anim.duration = duration;
    [layer addAnimation:anim forKey:nil];
    
    //  设置子层总数
    int count = 20;
    repL.instanceCount = count;
    // 复制图层的变换动画
    repL.instanceTransform = CATransform3DMakeRotation(M_PI * 2 / count, 0, 0, 1); // 旋转动画
    repL.instanceDelay = duration / count;
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
