//
//  SFJClipImageViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJClipImageViewController.h"

@interface SFJClipImageViewController ()

@end

@implementation SFJClipImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drawView.backgroundColor = [UIColor yellowColor];
    self.drawView.height = self.drawView.width;
    
    UIImage *image = [UIImage imageNamed:@"猫咪-1"];
    self.drawView.layer.contents = (__bridge id _Nullable)([SFJClipImageViewController imageWithClipImage:image borderWidth:3 borderColor:[UIColor RandomColor]].CGImage);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    // 图片的宽度和高度
    CGFloat imageWH = image.size.width;
    
    // 设置圆环的宽度
    CGFloat border = borderWidth;
    
    // 圆形的 半径
    CGFloat ovalWH = imageWH + 2 * border;
    
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    // 2.画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    [color set];
    [path fill];
    
    // 3.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clipPath addClip];
    
    // 4.绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    
    // 5.获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
}

@end
