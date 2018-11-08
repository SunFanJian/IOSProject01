//
//  SFJModalBlockViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJModalBlockViewController.h"

@interface SFJModalBlockViewController ()

@end

@implementation SFJModalBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !self.successBlock ? : self.successBlock(@"222");
       // self.successBlock(@"modal即将关闭！");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)subViewDoSomething
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"子页面其他操作");
    });
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
