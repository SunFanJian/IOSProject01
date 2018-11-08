//
//  SFJDrawStrPicsViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/8/29.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDrawStrPicsViewController.h"

@interface SFJDrawStrPicsViewController ()

@end

@implementation SFJDrawStrPicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DrawStrPicsView *view = [[DrawStrPicsView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kWIGTH , kHIGHT - NAVIGATION_BAR_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

@end

@implementation DrawStrPicsView
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 超出裁剪区域的内容全部裁剪掉
    // 注意：裁剪必须放在绘制之前
    //    UIRectClip(CGRectMake(0, 0, 50, 50));
   UIImage *image = [UIImage imageNamed:@"猫咪.jpg"];
    
    // 默认绘制的内容尺寸跟图片尺寸一样大
    //    [image drawAtPoint:CGPointZero];
    //    [image drawInRect:rect];
    // 绘图
    [image drawAsPatternInRect:rect];
    
    [self drawText];
    [self attrText];
}

- (void)drawText
{
    // 绘制文字
    NSString *str = @"绘制文字普通文字绘制文字普通文字绘制文字普通文字";
    // 不会换行
    // [str drawAtPoint:CGPointZero withAttributes:nil];
    [str drawInRect:CGRectMake(100, 100, 200, 100) withAttributes:nil];
}

-(void)attrText
{
    // 绘制文字
    NSString *str = @"我是富文本文字我是富文本文字我是富文本文字";
    
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    
    //设置文字颜色
    textDict[NSForegroundColorAttributeName] = [UIColor redColor];
    //字体
    textDict[NSFontAttributeName] = [UIFont systemFontOfSize:30];
    //文字 空心颜色&宽度
    textDict[NSStrokeWidthAttributeName] = @3;
    textDict[NSStrokeColorAttributeName] = [UIColor yellowColor];
    
    //设置阴影
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor greenColor];
    shadow.shadowOffset = CGSizeMake(4, 4);
    shadow.shadowBlurRadius = 3;
    
    textDict[NSShadowAttributeName] = shadow;
    
    // 富文本:给普通的文字添加颜色，字体大小
    [str drawAtPoint:CGPointZero withAttributes:textDict];
}
@end
