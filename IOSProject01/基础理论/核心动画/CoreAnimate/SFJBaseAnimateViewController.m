//
//  SFJBaseAnimateViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJBaseAnimateViewController.h"

@interface SFJBaseAnimateViewController ()<CAAnimationDelegate>

@end

@implementation SFJBaseAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/* 动画详解
 https://www.jianshu.com/p/02c341c748f9
 https://blog.csdn.net/chenyongkai1/article/details/75307674
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建基础动画
    CABasicAnimation *animate = [CABasicAnimation animation];  
    animate.delegate = self;
    
    // 描述下修改哪个属性产生动画
    // anim.keyPath = @"position";  //平移
    // 只能是layer属性
    animate.keyPath = @"transform.scale";   // 缩放动画
    
    // 设置值 - 所改变属性的结束时的值
    //anim.toValue = [NSValue valueWithCGPoint:CGPointMake(250, 500)];
    animate.toValue = @0.5;
    
    animate.repeatCount = 10;   // 动画执行次数
   
    // 取消动画反弹
    // 设置动画完成的时候不要移除动画
    animate.removedOnCompletion = NO;
    
      // 设置动画执行完成要保持最新的效果
    animate.fillMode = kCAFillModeForwards;
    
    [self.redView.layer addAnimation:animate forKey:nil];  // 给Layer 添加动画
    /*
     首先我们需要搞明白一点的是，layer动画运行的过程是怎样的？其实在我们给一个视图添加layer动画时，真正移动并不是我们的视图本身，而是 presentation layer 的一个缓存。动画开始时 presentation layer开始移动，原始layer隐藏，动画结束时，presentation layer从屏幕上移除，原始layer显示。这就解释了为什么我们的视图在动画结束后又回到了原来的状态，因为它根本就没动过。
     */
}

// 动画结束
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}
@end
