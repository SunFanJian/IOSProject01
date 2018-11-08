//
//  SFJFoldViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJFoldViewController.h"

@interface SFJFoldViewController ()
@property(strong , nonatomic)UIImageView *topImgView;
@property(strong , nonatomic)UIImageView *bottomImgView;
@property(nonatomic , strong)UIView *dragView;
@property (nonatomic, weak) CAGradientLayer *gradientL;
@end

@implementation SFJFoldViewController

//折叠
//一张图片必须要通过两个控件展示，旋转的时候，只旋转上部分控件
// 如何让一张完整的图片通过两个控件显示
// 通过layer控制图片的显示内容
// 如果快速把两个控件拼接成一个完整图片
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dragView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kWIGTH, 600)];
    _dragView.backgroundColor = [UIColor whiteColor];
    // 添加手势
    self.view.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_dragView addGestureRecognizer:pan];
    [self.view addSubview:_dragView];
    
    _topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 150, kWIGTH - 20, 300)];
    _topImgView.image = [UIImage imageNamed:@"猫咪-2"];
    //_topImgView.contentMode = UIViewContentModeScaleAspectFit;
    _topImgView.layer.contentsRect =  CGRectMake(0, 0, 1, 0.5); // 通过设置contentsRect可以设置图片显示的尺寸，取值0~1
    _topImgView.layer.anchorPoint = CGPointMake(0.5, 1);    // 锚点
    [self.dragView addSubview:_topImgView];
    
    _bottomImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 150, kWIGTH - 20, 300)];
    // _bottomImgView.contentMode = UIViewContentModeScaleAspectFit;
    _bottomImgView.image = [UIImage imageNamed:@"猫咪-2"];
    _bottomImgView.layer.contentsRect =  CGRectMake(0, 0.5, 1, 0.5); // 通过设置contentsRect可以设置图片显示的尺寸，取值0~1
    _bottomImgView.layer.anchorPoint = CGPointMake(0.5, 0);    // 锚点
    [self.dragView addSubview:_bottomImgView];
    
    // 设置渐变图层
    CAGradientLayer *gradientL = [CAGradientLayer layer];
    gradientL.frame = _bottomImgView.frame;
    gradientL.opacity = 0;  // 阴影
    gradientL.colors =  @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    _gradientL = gradientL;
    
    // 设置渐变定位点
    // gradientL.locations = @[@0.1,@0.4,@0.5];
    // 设置渐变开始点，取值0~1
    gradientL.startPoint = CGPointMake(0, 1);
    [_bottomImgView.layer addSublayer:gradientL];
}



// 拖动的时候旋转上部分内容，200 M_PI
- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint transP = [pan locationInView:_dragView];
     // 旋转角度,往下逆时针旋转
    CGFloat angle = -transP.y / 200.0 * M_PI;
    
    CATransform3D transfrom = CATransform3DIdentity;
    
    // 增加旋转的立体感，近大远小,d：距离图层的距离
    transfrom.m34 = -1 / 500.0;
    
    transfrom = CATransform3DRotate(transfrom, angle, 1, 0, 0);
    
    _topImgView.layer.transform = transfrom;
    
    // 设置阴影效果
    _gradientL.opacity = transP.y * 1 / 200.0;
    
    if (pan.state == UIGestureRecognizerStateEnded) { // 反弹
        
        // 弹簧效果的动画
        // SpringWithDamping:弹性系数,越小，弹簧效果越明显
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.topImgView.layer.transform = CATransform3DIdentity;
            self.gradientL.opacity = 0;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}
@end
