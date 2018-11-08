//
//  SFJDrawLineViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/8/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDrawLineViewController.h"

@interface SFJDrawLineViewController ()

@property(nonatomic , weak)LineView *redView;
@end

@implementation SFJDrawLineViewController

-(LineView *)redView
{
    if (!_redView) {
        LineView *redView = [[LineView alloc]initWithFrame:CGRectMake(0, 0, kWIGTH, 230)];
        redView.backgroundColor = [UIColor whiteColor];
        self.tableview.tableHeaderView = redView;
        _redView = redView;
    }
    return _redView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redView.drawTypeType = 5;
    LMJWeak(self);
    self.addItem([SFJTableItem itemWithTitle:@"最原始的绘图方式" subTitle:@"CGMutablePathRef" itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }])
    .addItem([SFJTableItem itemWithTitle:@"绘图第二种方式" subTitle:@"CGContextMoveToPoint" itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }])
    .addItem([SFJTableItem itemWithTitle:@"绘图第三种方式" subTitle:@"UIBezierPath" itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }])
    .addItem([SFJTableItem itemWithTitle:@"设置属性Ctx" subTitle:@"CGContextSet..." itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }])
    .addItem([SFJTableItem itemWithTitle:@"设置属性UIBezierPath" subTitle:@"drawUIBezierPathState" itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }])
    .addItem([SFJTableItem itemWithTitle:@"弧线" subTitle:@"CGContextAddQuadCurveToPoint" itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }])
    .addItem([SFJTableItem itemWithTitle:@"扇形或者圆形" subTitle:@"bezierPathWithArcCenter" itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }])
    .addItem([SFJTableItem itemWithTitle:@"圆角矩形" subTitle:@"bezierPathWithRoundedRect" itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }])
    .addItem([SFJTableItem itemWithTitle:@"同心圆" subTitle:@"bezierPathWithArcCenter" itemOperation:^(NSIndexPath *indexPath) {
        weakself.redView.drawTypeType = indexPath.row;
        [weakself.redView setNeedsDisplay];
    }]);
}

@end


@implementation LineView

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 绘图的步骤： 1.获取上下文 2.创建路径（描述路径） 3.把路径添加到上下文 4.渲染上下文
    
    // 通常在drawRect这个方法里面绘制图形
    // 为什么要再drawRect里面绘图，只有在这个方法里面才能获取到跟View的layer相关联的图形上下文
    // 什么时候调用:当这个View要显示的时候才会调用drawRect绘制图形，
    // 注意：rect是当前控件的bounds
    switch (self.drawTypeType) {
        case 0:
            [self drawLine];
            break;
           case 1:
            [self drawLine1];
            break;
            case 2:
            [self drawLine2];
            break;
            case 3:
            [self drawCtxState];
            break;
            case 4:
            [self drawUIBezierPathState];
            break;
            case 5:
            [self drawCornerLine];
            break;
            case 6:
            [self drawCircle];
            break;
            case 7:
            [self radiousRect];
            break;
            case 8:
            [self drawConcentricCircle];
            break;
        default:
            break;
    }
}

#pragma mark - 最原始的绘图方式
- (void)drawLine
{
    //1.获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2. 创建描述路径
    CGMutablePathRef path = CGPathCreateMutable();
    //2.1 设置路径 -- 起点
    CGPathMoveToPoint(path, NULL, 50, 50);
    //2.2 添加一根线到个点 -- 可以理解为终点
    CGPathAddLineToPoint(path, NULL, 200, 200);
    
    //3.将 路径 添加到 上下文
    CGContextAddPath(ctx, path);
    
    //4. 渲染上下文
    CGContextStrokePath(ctx);
    
    // 释放路径
    CGPathRelease(path);
}

#pragma mark - 绘图第二种方式
- (void)drawLine1
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 直接将 起始点 添加到 上下文
    CGContextMoveToPoint(ctx, 250, 50);
    
    CGContextAddLineToPoint(ctx, 50, 250);
    
    CGContextStrokePath(ctx);
}

#pragma mark - 绘图第三种方式
- (void)drawLine2
{
    //1. 创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2.设置起点
    [path moveToPoint:CGPointMake(150, 50)];
    //3.设置终点
    [path addLineToPoint:CGPointMake(200, 200)];
    //4.渲染路径
    [path stroke];
}

#pragma mark - 设置上下文属性
- (void)drawCtxState
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 绘制两条线
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 50);
    
    CGContextMoveToPoint(ctx, 80, 60);
    CGContextAddLineToPoint(ctx, 100, 200);
    
    // 设置上下文绘图属性 ， 一定要在渲染之前
    [[UIColor redColor] setStroke]; //颜色
    
    CGContextSetLineWidth(ctx, 5);  //线宽
    
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);//连接样式
    
    CGContextSetLineCap(ctx, kCGLineCapRound);  //顶角样式
    
    //渲染上下文
    CGContextStrokePath(ctx);
}

#pragma mark - 设置贝塞尔曲线属性
- (void)drawUIBezierPathState
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(200, 200)];
    
    path.lineWidth = 10;
    [[UIColor redColor] set];
    
    [path stroke];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    
    [path2 moveToPoint:CGPointMake(100, 50)];
    [path2 addLineToPoint:CGPointMake(200, 100)];
    
    path2.lineWidth = 3;
    [[UIColor blueColor] set];
    path2.lineJoinStyle = kCGLineJoinBevel;
    
    [path2 stroke];
}

// 绘制曲线
- (void)drawCornerLine
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 50, 150);
    //                                控制点     终点
    CGContextAddQuadCurveToPoint(ctx, 150, 80, 250, 150);
    
    CGContextStrokePath(ctx);
}

//绘制圆弧
- (void)drawCircle
{
    CGPoint center = CGPointMake(120, 120);
    // 圆弧
    // Center：圆心
    // radius:半径
    // Angle:弧度
    // clockwise:YES:顺时针 NO：逆时针
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    // 添加一根线到圆心
    [path addLineToPoint:center];
        // 封闭路径，关闭路径：从路径的终点到起点
    [path closePath];
    
    path.lineWidth = 3;
    [[UIColor redColor] set];
    [path stroke];
    
    [[UIColor greenColor] setFill];
    // 填充：必须是一个完整的封闭路径,默认就会自动关闭路径
    [path fill];
}

// 圆角矩形
- (void)radiousRect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 350, 200) cornerRadius:30];
    path.lineWidth = 10;
    [[UIColor redColor] set];
    [path stroke];
}

//同心圆
-(void)drawConcentricCircle
{
    CGPoint center = CGPointMake(150, 150);
    
    //外圆
    UIBezierPath *pathOut = [UIBezierPath bezierPathWithArcCenter:center radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];  //外面的圆路径
    [pathOut closePath];
    
    pathOut.lineWidth = 3;
    [pathOut stroke];
    
    [[UIColor blueColor] setFill];
    [pathOut fill];
    
    
    //内圆
    UIBezierPath *pathIn = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES]; 
    [pathIn closePath];

    pathIn.lineWidth = 3;
    [pathIn stroke];

    [[UIColor greenColor] setFill];
    [pathIn fill];
}
@end
