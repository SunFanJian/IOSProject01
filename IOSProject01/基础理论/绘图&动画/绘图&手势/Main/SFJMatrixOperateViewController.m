//
//  SFJMatrixOperateViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJMatrixOperateViewController.h"

@interface SFJMatrixOperateViewController ()

@end

@implementation SFJMatrixOperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    matrixView *view = [[matrixView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kWIGTH , kHIGHT - NAVIGATION_BAR_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

@end

@implementation matrixView
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //1.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
   //2.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-100, -50, 200, 100)];
    
    [[UIColor redColor] set];
    // 上下文矩阵操作
    // 注意:矩阵操作必须要在添加路径之前=========
    //  平移
    CGContextTranslateCTM(ctx, 100, 50);
    //缩放
    CGContextScaleCTM(ctx, 0.5, 0.5);
    // 旋转
    CGContextRotateCTM(ctx, M_PI_4);
    
    //3. 添加 路径
    CGContextAddPath(ctx, path.CGPath);
    
    //渲染
 //   CGContextStrokePath(ctx);
    CGContextFillPath(ctx); // 填充
    
}
@end

