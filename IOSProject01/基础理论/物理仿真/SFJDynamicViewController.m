//
//  SFJDynamicViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/21.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDynamicViewController.h"
#import "SFJDynamicDemoViewController.h"

@interface SFJDynamicViewController ()

@end

@implementation SFJDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSArray *dynamicArr = @[@"吸附行为", @"推动行为", @"刚性附着行为", @"弹性附着行为", @"碰撞检测"];
    
    LMJWeak(self);
    self.addItem([SFJTableArrowItem itemWithTitle:@"吸附行为" subTitle:@"UISnapBehavior" itemOperation:^(NSIndexPath *indexPath) {
        SFJDynamicDemoViewController *demoVC = [[SFJDynamicDemoViewController alloc]init];
        demoVC.title = @"吸附行为";
        demoVC.type = (int)indexPath.row;
        [weakself.navigationController pushViewController:demoVC animated:YES];
    }])
    .addItem([SFJTableArrowItem itemWithTitle:@"推动行为" subTitle:@"UIPushBehavior" itemOperation:^(NSIndexPath *indexPath) {
        SFJDynamicDemoViewController *demoVC = [[SFJDynamicDemoViewController alloc]init];
        demoVC.title = @"推动行为";
        demoVC.type = (int)indexPath.row;
        [weakself.navigationController pushViewController:demoVC animated:YES];
    }])
    .addItem([SFJTableArrowItem itemWithTitle:@"刚性附着行为" subTitle:@"UIAttachmentBehavior" itemOperation:^(NSIndexPath *indexPath) {
        SFJDynamicDemoViewController *demoVC = [[SFJDynamicDemoViewController alloc]init];
        demoVC.title = @"刚性附着行为";
        demoVC.type = (int)indexPath.row;
        [weakself.navigationController pushViewController:demoVC animated:YES];
    }])
    .addItem([SFJTableArrowItem itemWithTitle:@"弹性附着行为" subTitle:@"UIGravityBehavior" itemOperation:^(NSIndexPath *indexPath) {
        SFJDynamicDemoViewController *demoVC = [[SFJDynamicDemoViewController alloc]init];
        demoVC.title = @"弹性附着行为";
        demoVC.type = (int)indexPath.row;
        [weakself.navigationController pushViewController:demoVC animated:YES];
    }])
    .addItem([SFJTableArrowItem itemWithTitle:@"碰撞检测" subTitle:@"UICollisionBehavior" itemOperation:^(NSIndexPath *indexPath) {
        SFJDynamicDemoViewController *demoVC = [[SFJDynamicDemoViewController alloc]init];
        demoVC.title = @"碰撞检测";
        demoVC.type = (int)indexPath.row;
        [weakself.navigationController pushViewController:demoVC animated:YES];
    }]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
