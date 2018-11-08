//
//  SFJCALayerViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/5.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJCALayerViewController.h"

@interface SFJCALayerViewController ()

@end

@implementation SFJCALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.fd_interactivePopDisabled = YES;
    [self.view makeToast:@"点击屏幕" duration:3 position:CSToastPositionCenter];
}

- (UIView *)redView
{
    if(!_redView)
    {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 150, 200)];
        [self.view addSubview:redView];
        _redView = redView;
        redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

-(CALayer *)blueLayer
{
    if (!_blueLayer) {
        CALayer *blueLayer = [CALayer layer];
        [self.view.layer addSublayer:blueLayer];
        blueLayer.backgroundColor = [UIColor blueColor].CGColor;
        blueLayer.frame = CGRectMake(50, 350, 100, 70);
        _blueLayer = blueLayer;
    }
    return _blueLayer;
}

@end
