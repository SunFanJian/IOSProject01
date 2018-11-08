//
//  SFJimplicitViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/5.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJimplicitViewController.h"
#define angle2radion(angle) ((angle) / 180.0 * M_PI)

@interface SFJimplicitViewController ()

@end

@implementation SFJimplicitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.blueLayer.position = CGPointMake(200, 150);    //中心点
    self.blueLayer.anchorPoint = CGPointZero;  // 定义锚点
    self.blueLayer.bounds = CGRectMake(0, 0, 80, 80);
    self.blueLayer.backgroundColor = [UIColor greenColor].CGColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.blueLayer.transform = CATransform3DMakeRotation(angle2radion(arc4random_uniform(360) + 1), 0, 0, 1);
    self.blueLayer.position = CGPointMake(arc4random_uniform(200) + 20, arc4random_uniform(400) + 50);
    self.blueLayer.cornerRadius = arc4random_uniform(50);
    self.blueLayer.backgroundColor = [UIColor RandomColor].CGColor;
    self.blueLayer.borderWidth = arc4random_uniform(10);
    self.blueLayer.borderColor = [UIColor RandomColor].CGColor;
}

@end
