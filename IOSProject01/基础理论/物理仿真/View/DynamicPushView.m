//
//  DynamicPushView.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/22.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "DynamicPushView.h"

@interface DynamicPushView ()
{
    UIImageView *_smallView;
    UIPushBehavior *_push;
    CGPoint _firstPoint;
    CGPoint _currentPoint;
}

@end

@implementation DynamicPushView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *smallImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AttachmentPoint_Mask"]];
        smallImg.hidden = NO;
        smallImg.center = CGPointMake(100, 200);
        [self addSubview:smallImg];
        _smallView = smallImg;
        
        //添加推动行为
        UIPushBehavior *push = [[UIPushBehavior alloc]initWithItems:@[self.boxView] mode:UIPushBehaviorModeInstantaneous];
        [self.animator addBehavior:push];
        _push = push;
        
        //添加碰撞行为
        UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[self.boxView]];
        collision.translatesReferenceBoundsIntoBoundary = YES;
        //        collision.collisionMode = UICollisionBehaviorModeBoundaries;
        [self.animator addBehavior:collision];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

-(void)panAction:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        // 获取起点位置
        _firstPoint = [pan locationInView:self];
        _smallView.center = _firstPoint;
        _smallView.hidden = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged){
        _currentPoint = [pan locationInView:self];
        [self setNeedsDisplay];
    }else if (pan.state == UIGestureRecognizerStateEnded)
    {
        //计算偏移量
        CGPoint offset = CGPointMake(_currentPoint.x - _firstPoint.x, _currentPoint.y - _firstPoint.y);
     
        //计算角度
        CGFloat angle = atan2(offset.y, offset.x);
        // 计算距离
        CGFloat distance = hypot(offset.y, offset.x);
        
        //设置推动的大小、角度
        _push.magnitude = distance;
        _push.angle = angle;
        // 使单次推行为有效
        _push.active = YES;   // 拖拽结束、开始推动
        
        _firstPoint = CGPointZero;
        _currentPoint = CGPointZero;
        
        _smallView.hidden = YES;
        [self setNeedsDisplay];
    }
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctRef = UIGraphicsGetCurrentContext();
    
    //绘制拖拽的轨迹线
    CGContextMoveToPoint(ctRef, _firstPoint.x, _firstPoint.y);
    CGContextAddLineToPoint(ctRef, _currentPoint.x, _currentPoint.y);
    
    CGContextSetLineWidth(ctRef, 10);
    CGContextSetLineJoin(ctRef, kCGLineJoinRound);
    CGContextSetLineCap(ctRef, kCGLineCapRound);
    [[UIColor RandomColor] setStroke];
    
    CGContextStrokePath(ctRef);
}
@end
