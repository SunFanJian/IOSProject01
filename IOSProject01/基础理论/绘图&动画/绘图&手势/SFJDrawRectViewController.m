//
//  SFJDrawRectViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/8/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDrawRectViewController.h"

#import "SFJDrawLineViewController.h"
#import "SFJDrawProgressViewController.h"
#import "SFJDrwsPieViewController.h"
#import "SFJDrawBarViewController.h"
#import "SFJDrawStrPicsViewController.h"
#import "SFJDrawXueHuaViewController.h"
#import "SFJContextViewController.h"
#import "SFJMatrixOperateViewController.h"
#import "SFJWaterMarkViewController.h"
#import "SFJClipImageViewController.h"
#import "SFJScreenShotViewController.h"
#import "SFJClipPictureViewController.h"
#import "SFJErasureViewController.h"
#import "SFJFingerLockViewController.h"

@interface SFJDrawRectViewController ()

@end

@implementation SFJDrawRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    SFJTableArrowItem *item0 = [SFJTableArrowItem itemWithTitle:@"基本图形绘制" subTitle:nil];
    item0.destVc = [SFJDrawLineViewController class];
    
    SFJTableArrowItem *item1 = [SFJTableArrowItem itemWithTitle:@"下载进度" subTitle:nil];
    item1.destVc = [SFJDrawProgressViewController class];
    
    SFJTableArrowItem *item2 = [SFJTableArrowItem itemWithTitle:@"画饼图" subTitle:nil];
    item2.destVc = [SFJDrwsPieViewController class];
    
    SFJTableArrowItem *item3 = [SFJTableArrowItem itemWithTitle:@"柱状图" subTitle:nil];
    item3.destVc = [SFJDrawBarViewController class];
    
    SFJTableArrowItem *item4 = [SFJTableArrowItem itemWithTitle:@"图片和文字" subTitle:nil];
    item4.destVc = [SFJDrawStrPicsViewController class];
    
    SFJTableArrowItem *item5 = [SFJTableArrowItem itemWithTitle:@"下雪定时器" subTitle:@"CADisplayLink"];
    item5.destVc = [SFJDrawXueHuaViewController class];
    
    SFJTableArrowItem *item6 = [SFJTableArrowItem itemWithTitle:@"图形上下文栈" subTitle:@"CGContextSaveGState"];
    item6.destVc = [SFJContextViewController class];
    
    SFJTableArrowItem *item7 = [SFJTableArrowItem itemWithTitle:@"矩阵操作" subTitle:nil];
    item7.destVc = [SFJMatrixOperateViewController class];
    
    SFJTableArrowItem *item8 = [SFJTableArrowItem itemWithTitle:@"图片水印" subTitle:nil];
    item8.destVc = NSClassFromString(@"SFJWaterMarkViewController");
    
    SFJTableArrowItem *item9 = [SFJTableArrowItem itemWithTitle:@"裁剪图片" subTitle:nil];
    item9.destVc = NSClassFromString(@"SFJClipImageViewController");
    
    
    SFJTableArrowItem *item10 = [SFJTableArrowItem itemWithTitle:@"截屏" subTitle:nil];
    item10.destVc = NSClassFromString(@"SFJScreenShotViewController");
    
    SFJTableArrowItem *item11 = [SFJTableArrowItem itemWithTitle:@"截取图片" subTitle:nil];
    item11.destVc = NSClassFromString(@"SFJClipPictureViewController");
    
    SFJTableArrowItem *item12 = [SFJTableArrowItem itemWithTitle:@"图片擦除" subTitle:nil];
    item12.destVc = NSClassFromString(@"SFJErasureViewController");
    
    SFJTableArrowItem *item13 = [SFJTableArrowItem itemWithTitle:@"绘图" subTitle:@"所有的UIGestureRecognizers 用法"];
   // item13.destVc = NSClassFromString(@"LMJDrawBoardViewController");
    
    SFJTableArrowItem *item14 = [SFJTableArrowItem itemWithTitle:@"九宫格解锁" subTitle:nil];
    item14.destVc = NSClassFromString(@"SFJFingerLockViewController");
    
    SFJTableSection *section0 = [SFJTableSection sectionWithItems:@[item0, item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14] andHeaderTitle:nil footerTitle:nil];
    
    [self.sections addObject:section0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
