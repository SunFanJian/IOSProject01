//
//  DynamicSpringView.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/22.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "DynamicSpringView.h"

@implementation DynamicSpringView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 振幅
        //        self.attachment.damping = 1.0f;
        
        // 频率(让线具有弹性)
        //        self.attachment.frequency = 1.0f;
        
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.boxView]];
        [self.animator addBehavior:gravity];
        
        // 利用KVO监听方块中心点的改变
        /**
         self.boxView   被监听的对象
         observer       监听者
         keypath        监听的键值
         options        监听什么值
         */
        [self.boxView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
     [self setNeedsDisplay];
}

- (void)dealloc {
    [self.boxView removeObserver:self forKeyPath:@"center"];
}
@end
