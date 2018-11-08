//
//  DynamicCollisionView.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/22.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "DynamicCollisionView.h"

@implementation DynamicCollisionView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加重力行为
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.boxView]];
        [self.animator addBehavior:gravity];
        
        //添加碰撞行为
        UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[self.boxView]];
        collision.translatesReferenceBoundsIntoBoundary = YES;   // 把物理仿真器的边界也作为碰撞对象
        
        // 3. 添加一个红色view
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 350, 180, 30)];
        redView.backgroundColor = [UIColor redColor];
        [self addSubview:redView];
        redView.alpha = 0.4;
        
           // 4. 手动添加碰撞, 通过bezierPath 模拟 边界
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(redView.frame.origin.x, redView.frame.origin.y, redView.width + 10, redView.height + 10)];
        [collision addBoundaryWithIdentifier:@"redBoundary" forPath:path];
        [self.animator addBehavior:collision];
        
          // 5. 物体的属性行为
        UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc]initWithItems:@[self.boxView]];
        item.elasticity = 0.8;  //设置物体弹性，振幅
        [self.animator addBehavior:item];
        
    }
    return self;
}

@end
