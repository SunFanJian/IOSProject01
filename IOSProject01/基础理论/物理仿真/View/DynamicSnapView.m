//
//  DynamicSnapView.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/22.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "DynamicSnapView.h"

@implementation DynamicSnapView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 开始前先清除 之前的 仿真动作
    [self.animator removeAllBehaviors];
    
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    
    // 创建吸附事件
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.boxView snapToPoint:loc];
    // 改变震动幅度，0表示振幅最大，1振幅最小
    snap.damping = 0.5;
    // 4. 将吸附事件添加到仿真者行为中
    [self.animator addBehavior:snap];
}

@end
