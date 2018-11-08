//
//  SFJWaterMarkViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJWaterMarkViewController.h"

@interface SFJWaterMarkViewController ()

@end

@implementation SFJWaterMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIImage *image = [UIImage imageNamed:@"猫咪-1"];
    
    // 开启位图上下文
    // 0.获取上下文，之前的上下文都是在view的drawRect方法中获取（跟View相关联的上下文layer上下文）
    // 目前我们需要绘制图片到新的图片上，因此需要用到位图上下文
    
    // 怎么获取位图上下文,注意位图上下文的获取方式跟layer上下文不一样。位图上下文需要我们手动创建。
    // 开启一个位图上下文，注意位图上下文跟view无关联，所以不需要在drawRect.
    // size:位图上下文的尺寸（新图片的尺寸）
    // opaque: 不透明度 YES：不透明 NO:透明，通常我们一般都弄透明的上下文
    // scale:通常不需要缩放上下文，取值为0，表示不缩放
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, 0);
    
    // 1.绘制原生的图片
    [image drawInRect:CGRectMake(0, 0, 200, 200)];
    // 2.给原生的图片添加文字
    NSString *str = @"给原生的图片添加文字给原生的图片添加文字";
    
    //2.1 设置水印文字属性
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSForegroundColorAttributeName] = [UIColor blueColor];
    textDict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    [str drawAtPoint:CGPointMake(100, 128) withAttributes:textDict];
    
    // 3.生成一张图片给我们,从位图上下文中获取图片
    UIImage *imageWater = UIGraphicsGetImageFromCurrentImageContext();
    //4. 关闭上下文
    UIGraphicsEndImageContext();
    
  //  self.view.layer.contents = (__bridge id _Nullable)(imageWater.CGImage);
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kWIGTH, kHIGHT / 2)];
    imgView.image = imageWater;
    [self.view addSubview:imgView];
}
@end
