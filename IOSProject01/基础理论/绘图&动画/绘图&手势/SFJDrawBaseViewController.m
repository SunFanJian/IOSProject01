//
//  SFJDrawBaseViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/8/28.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDrawBaseViewController.h"

@interface SFJDrawBaseViewController ()

@end

@implementation SFJDrawBaseViewController

-(UIView *)drawView
{
    if (!_drawView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 20, kWIGTH, 330)];
        _drawView = view;
        [self.view addSubview:view];
    }
    return _drawView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.drawView.backgroundColor = [UIColor whiteColor];
}



@end
