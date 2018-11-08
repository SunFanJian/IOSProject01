//
//  SFJCoreAnimateViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/5.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJCoreAnimateViewController.h"
#import "SFJCALayerBaseViewController.h"
#import "SFJimplicitViewController.h"
#import "SFJBaseAnimateViewController.h"
#import "SFJCAKeyFrameAnimateViewController.h"
#import "SFJCATransitionViewController.h"
#import "SFJCAAnimationGroupViewController.h"
#import "SFJFoldViewController.h"
#import "SFJVoiceLineViewController.h"
#import "SFJHUDViewController.h"
#import "SFJOneParticleViewController.h"
#import "SFJMuchParticleViewController.h"
#import "SFJInvertedViewController.h"

@interface SFJCoreAnimateViewController ()

@end

@implementation SFJCoreAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SFJTableArrowItem *item0 = [SFJTableArrowItem itemWithTitle:@"CALayer基本使用" subTitle:@"CALayer新建图层"];
    item0.destVc = [SFJCALayerBaseViewController class];
    
    SFJTableArrowItem *item2 = [SFJTableArrowItem itemWithTitle:@"CALayer隐式动画" subTitle:@"非根Layer默认有动画"];
    item2.destVc = [SFJimplicitViewController class];
    
    SFJTableArrowItem *item3 = [SFJTableArrowItem itemWithTitle:@"时钟" subTitle:@"anchorPoint&position"];
   // item3.destVc = [LMJCAClockViewController class];
    
    SFJTableArrowItem *item4 = [SFJTableArrowItem itemWithTitle:@"核心动画CABasicA" subTitle:@"strong delegate?"];
    item4.destVc = [SFJBaseAnimateViewController class];
    
    
    SFJTableArrowItem *item5 = [SFJTableArrowItem itemWithTitle:@"关键帧动画CAKeyFrameA" subTitle:@"Value&path"];
    item5.destVc = [SFJCAKeyFrameAnimateViewController class];
    
    
    SFJTableArrowItem *item6 = [SFJTableArrowItem itemWithTitle:@"CATransition转场动画" subTitle:@"type"];
    item6.destVc = [SFJCATransitionViewController class];
    
    SFJTableArrowItem *item7 = [SFJTableArrowItem itemWithTitle:@"动画组CAGroupA" subTitle:nil];
    item7.destVc = [SFJCAAnimationGroupViewController class];
    
    SFJTableArrowItem *item8 = [SFJTableArrowItem itemWithTitle:@"折叠图片" subTitle:@"CAGradientLayer"];
    item8.destVc = [SFJFoldViewController class];
    
    SFJTableArrowItem *item9 = [SFJTableArrowItem itemWithTitle:@"音量震动条" subTitle:@"CAReplicatorLayer"];
    item9.destVc = [SFJVoiceLineViewController class];
    
    SFJTableArrowItem *item10 = [SFJTableArrowItem itemWithTitle:@"活动指示器" subTitle:@"CAReplicatorLayer"];
    item10.destVc = [SFJHUDViewController class];
    
    SFJTableArrowItem *item11 = [SFJTableArrowItem itemWithTitle:@"粒子动画单条" subTitle:@"CAReplicatorLayer"];
    item11.destVc = [SFJOneParticleViewController class];
    
    SFJTableArrowItem *item12 = [SFJTableArrowItem itemWithTitle:@"粒子动画多条" subTitle:@"CAReplicatorLayer"];
    item12.destVc = [SFJMuchParticleViewController class];
    
    SFJTableArrowItem *item13 = [SFJTableArrowItem itemWithTitle:@"倒影" subTitle:@"CAReplicatorLayer"];
    item13.destVc = [SFJInvertedViewController class];
    
    SFJTableSection *section0 = [SFJTableSection sectionWithItems:@[item0, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13] andHeaderTitle:nil footerTitle:nil];
    
    [self.sections addObject:section0];
}

@end
