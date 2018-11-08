//
//  DynamicBaseView.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/21.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "DynamicBaseView.h"

@implementation DynamicBaseView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTile"]];
        
        UIImageView *boxView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Box1"]];
        boxView.center = CGPointMake(200, 200);
//        boxView.userInteractionEnabled = YES;
        [self addSubview:boxView];
        self.boxView = boxView;
        
        UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
        
        //        UIDynamic－iOS中的物理引擎
        
        //        1, 创建一个物理仿真器 设置仿真范围
        //        2, 创建相应的物理仿真行为, 添加物理仿真元素
        //        3, 将物理仿真行为添加到仿真器中开始仿真
        
        self.animator = animator;
    }
    return self;
}

@end
