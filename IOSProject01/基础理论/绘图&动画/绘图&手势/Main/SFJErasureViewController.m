//
//  SFJErasureViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJErasureViewController.h"

@interface SFJErasureViewController ()
@property (strong, nonatomic) UIImageView *imageV;
@end

@implementation SFJErasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_imageV];
    _imageV.image = [UIImage imageNamed:@"猫咪-2"];
    
    // 添加手势
    [_imageV setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(erasurePicture:)];
    [_imageV addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)erasurePicture:(UIPanGestureRecognizer *)pan
{
    CGPoint curP = [pan locationInView:_imageV];
    // 获取擦除的矩形范围
    CGFloat wh = 50;
    CGFloat x = curP.x - wh/2;
    CGFloat y = curP.y - wh/2;
    
    CGRect rect = CGRectMake(x, y, wh, wh);
    
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(_imageV.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 控件的layer渲染上去
    [_imageV.layer renderInContext:ctx];
    
    // 擦除图片
    CGContextClearRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    _imageV.image = image;
    
    UIGraphicsEndImageContext();
}

@end
