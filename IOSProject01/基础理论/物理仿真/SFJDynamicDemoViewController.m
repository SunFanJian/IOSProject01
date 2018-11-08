//
//  SFJDynamicDemoViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/21.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDynamicDemoViewController.h"
#import "DynamicBaseView.h"
#import "DynamicSnapView.h"
#import "DynamicPushView.h"
#import "SFJAttachmentView.h"
#import "DynamicSpringView.h"
#import "DynamicCollisionView.h"

@interface SFJDynamicDemoViewController ()

@end

@implementation SFJDynamicDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SFJBGColor;
    
    DynamicBaseView *baseView = nil;
    
    switch (self.type) {
        case 0:
            baseView = [[DynamicSnapView alloc]init];
            break;
         case 1:
            baseView = [[DynamicPushView alloc]init];
            break;
            case 2:
            baseView = [[SFJAttachmentView alloc]init];
            break;
            case 3:
            baseView = [[DynamicSpringView alloc]init];
            break;
        case 4:
            baseView = [[DynamicCollisionView alloc]init];
            break;
        default:
            break;
    }
    
    [self.view addSubview:baseView];
    
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(NAVIGATION_BAR_HEIGHT + 10, 10, 10, 10));
    }];
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
