//
//  SFJCATransitionViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJCATransitionViewController.h"

@interface SFJCATransitionViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation SFJCATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 200, kWIGTH - 10, 300)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
}

/* 转场动画
 https://www.jianshu.com/p/cb437c3f3f58
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 2;
    
    // 转场代码
    if (i == 5) {
        i = 1;
    }
    
    NSString *imageN = [NSString stringWithFormat:@"CATransition%d.png",i];
    self.imageView.image = [UIImage imageNamed:imageN];
    i++;
    
    // 转场动画
    //CATransition通常用于通过CALayer控制UIView内子控件的过渡动画
    CATransition *animate = [CATransition animation];
    animate.type = @"rippleEffect";
    animate.subtype = kCATransitionFromRight;   // 动画执行方向
    animate.duration = 2;
    [_imageView.layer addAnimation:animate forKey:nil];

    /*
     kCATransitionFade 渐变
     kCATransitionMoveIn 覆盖
     kCATransitionPush 推出
     kCATransitionReveal 揭开
     
     私有动画
     cube 立方体旋转
     suckEffect  收缩动画
     oglFlip  翻转
     rippleEffect  水波动画
     pageCurl  页面揭开
     pageUnCurl 放下页面
     cemeraIrisHollowOpen  镜头打开
     cameraIrisHollowClose 镜头关闭
     
     */
}

//- (UIImageView *)imageView
//{
//    if(!_imageView)
//    {
//        _imageView = [[UIImageView alloc] init];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [self.view addSubview:_imageView];
//
//        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//           // make.edges.insets(UIEdgeInsetsMake(90, 20, 20, 20));
//            make.centerY.equalTo(self);
//            make.size.mas_equalTo(CGSizeMake(kWIGTH - 10, 300));
//        }];
//    }
//    return _imageView;
//}
@end
