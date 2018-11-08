//
//  SFJContextViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJContextViewController.h"

@interface SFJContextViewController ()

@end

@implementation SFJContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    ShangXiaWenView *view = [[ShangXiaWenView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kWIGTH , kHIGHT - NAVIGATION_BAR_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation ShangXiaWenView
// 如果以后用贝瑟尔绘制图形【path stroke】,上下文的状态由贝瑟尔路径状态
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 描述路径 - 贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    //添加一根线
    [path moveToPoint:CGPointMake(10, 125)];
    [path addLineToPoint:CGPointMake(240, 125)];
    // 把路径 添加到 上下文
    CGContextAddPath(ctx, path.CGPath);     //.CGPath 可以UIkit的路径转换成CoreGraphics路径
    // 保存 上下文状态
    CGContextSaveGState(ctx);
    //设置上下文
    CGContextSetLineWidth(ctx, 10);
    [[UIColor redColor] set];
    // 渲染上下文
    CGContextStrokePath(ctx);
    
    // 绘制第一根线的时候将上下文状态保存了 ， 绘制第二根线的时候就不受上次的上下文状态影响
    // 添加 第二个 路径
    path = [UIBezierPath bezierPath];
    
    [path moveToPoint: CGPointMake(125, 10)];
    [path addLineToPoint:CGPointMake(125, 240)];
    
    CGContextAddPath(ctx, path.CGPath);
    // 还原状态         保存 和 还原 同时使用
    CGContextRestoreGState(ctx);
    // 渲染
    CGContextStrokePath(ctx);
}
@end
