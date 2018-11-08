//
//  SFJClipPictureViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJClipPictureViewController.h"

@interface SFJClipPictureViewController ()
@property (weak, nonatomic) UIImageView *imageV;
@property (nonatomic, strong) UIView *clipView;

@property (nonatomic, assign) CGPoint startP;
@end

@implementation SFJClipPictureViewController

-(UIView *)clipView
{
    if (!_clipView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        view.alpha = 0.5;
        [self.imageV addSubview:view];
        _clipView = view;
    }
    return _clipView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [MBProgressHUD showAutoMessage:@"手指拖拽截图"];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imgView];
    _imageV = imgView;
    _imageV.image = [UIImage imageNamed:@"猫咪-2"];
    
    [_imageV setUserInteractionEnabled:YES];  // 很关键 少了就没效果
    //添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(clipPicture:)];
    [self.imageV addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clipPicture:(UIPanGestureRecognizer *)pan
{
    // 结束点
    CGPoint endA = CGPointZero;
    
    if (pan.state == UIGestureRecognizerStateBegan) {   // 开始
        _startP = [pan locationInView:self.imageV];
    }else if (pan.state == UIGestureRecognizerStateChanged){    // 拖拽过程中
        endA = [pan locationInView:self.imageV];
        
        CGFloat clipW = endA.x - _startP.x;
        CGFloat clipH = endA.y - _startP.y;
        // 截取范围
        CGRect clipRect = CGRectMake(_startP.x, _startP.y, clipW, clipH);
        //生成截取的view
        self.clipView.frame = clipRect;
    }else if (pan.state == UIGestureRecognizerStateEnded){   //结束
        if (CGRectEqualToRect(_clipView.frame, CGRectZero)) {       // 没有截取图片
            return;
        }
        // 开启位图上下文
        UIGraphicsBeginImageContextWithOptions(_imageV.bounds.size, NO, 0);
        
        //设置裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:_clipView.frame];
        [path addClip];
        // 截取的view设置为0
        _clipView.frame = CGRectZero;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        // 把控件上的内容渲染到上下文
        [_imageV.layer renderInContext:ctx];
         // 生成一张新的图片
        _imageV.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
}

-(UIImage *)sfjNavigationBarRightButtonImage:(UIButton *)RightButton navigationBar:(SFJNavigationBar *)navigationBar
{
    [RightButton setTitle:@"恢复" forState: UIControlStateNormal];
    [RightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return nil;
}

-(void)rightButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
    _imageV.image = [UIImage imageNamed:@"猫咪-2"];
}
@end
