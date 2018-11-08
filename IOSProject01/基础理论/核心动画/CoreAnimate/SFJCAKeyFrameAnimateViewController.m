//
//  SFJCAKeyFrameAnimateViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJCAKeyFrameAnimateViewController.h"

@interface SFJCAKeyFrameAnimateViewController ()

@end

@implementation SFJCAKeyFrameAnimateViewController

-(void)loadView
{
    self.view = [[DrawView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showAutoMessage:@"手指移动画线"];
    self.blueLayer.bounds = CGRectMake(0, 0, 50, 50);
}
@end

@interface DrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DrawView
// 点击
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint curP = [touch locationInView:self]; // 获取手指触摸点
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    _path = path;
    
    [path moveToPoint:curP];
}

// 手势拖动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint curP = [touch locationInView:self];
    
    [_path addLineToPoint:curP];    // 添加线
    
    [self setNeedsDisplay];  // 绘图
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建 关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    
    // 动画路径可以通过 Values和Path 设置
//     static BOOL isValue;
//    if (isValue) {
//        anim.values = @[@(100),@(-100),@(100)];
//        isValue = NO;
//    }else{
        anim.path = _path.CGPath;   // 动画移动路径   如果设置了path，那么values将被忽略
//        isValue = YES;
//    }
    
    anim.duration = 3; //动画执行时间
    anim.repeatCount = MAXFLOAT; // 动画执行次数
    
     [[(SFJCALayerViewController *)self.viewController blueLayer] addAnimation:anim forKey:nil]; // 给layer 添加关键帧动画
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor RandomColor] setStroke];
    
    [_path stroke]; // 渲染 路线
}

/*
 - transform.rotation.x 围绕x轴翻转 参数：角度 angle2Radian(4)
 
 transform.rotation.y 围绕y轴翻转 参数：同上
 
 transform.rotation.z 围绕z轴翻转 参数：同上
 
 transform.rotation 默认围绕z轴
 
 transform.scale.x x方向缩放 参数：缩放比例 1.5
 
 transform.scale.y y方向缩放 参数：同上
 
 transform.scale.z z方向缩放 参数：同上
 
 transform.scale 所有方向缩放 参数：同上
 
 transform.translation.x x方向移动 参数：x轴上的坐标 100
 
 transform.translation.y x方向移动 参数：y轴上的坐标
 
 transform.translation.z x方向移动 参数：z轴上的坐标
 
 transform.translation 移动 参数：移动到的点 （100，100）
 
 */
@end

