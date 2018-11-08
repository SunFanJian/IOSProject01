//
//  SFJScreenShotViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJScreenShotViewController.h"

@interface SFJScreenShotViewController ()

@end

@implementation SFJScreenShotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 生成一张新的图片
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"猫咪-1"]];
    [self.view addSubview:imgView];
    
    UIImage *image =  [SFJScreenShotViewController imageWithCaputureView:[UIApplication sharedApplication].delegate.window];
    
    UIImageView *imv = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imv];
    imv.frame = CGRectMake(0, 80, 300, 500);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 截屏*/
+(UIImage *)imageWithCaputureView:(UIView *)view
{
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(view.size, NO, 0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ctx];
    // 生产截取后的新图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭位图上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
