//
//  SFJAttachmentView.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/22.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJAttachmentView.h"

@interface SFJAttachmentView ()
{
    // 附着点图片框
    UIImageView *_anchorImgView;
    
    // 参考点图片框（boxView 内部）
    UIImageView *_offsetImgView;
}
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@end

@implementation SFJAttachmentView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置附着点
        CGPoint anchorPoint = CGPointMake(200, 100);
        UIOffset offset = UIOffsetMake(20, 20);
        
        //  添加附着行为
        UIAttachmentBehavior *accachment = [[UIAttachmentBehavior alloc]initWithItem:self.boxView offsetFromCenter:offset attachedToAnchor:anchorPoint];
        [self.animator addBehavior:accachment];
        self.attachment = accachment;
        
        // 4. 设置附着点图片(即直杆与被拖拽图片的连接点)
        UIImage *image = [UIImage imageNamed:@"AttachmentPoint_Mask"];
        UIImageView *anchorImgView = [[UIImageView alloc] initWithImage:image];
        anchorImgView.center = anchorPoint;
        
        [self addSubview:anchorImgView];
        _anchorImgView = anchorImgView;
        
        // 3. 设置参考点
        _offsetImgView = [[UIImageView alloc] initWithImage:image];
        
        CGFloat x = self.boxView.bounds.size.width * 0.5 + offset.horizontal;
        CGFloat y = self.boxView.bounds.size.height * 0.5 + offset.vertical;
        _offsetImgView.center = CGPointMake(x, y);
        [self.boxView addSubview:_offsetImgView];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        
    }
    return self;
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    CGPoint loc = [pan locationInView:self];
    
    //修改附着行为的附着点
    _anchorImgView.center = loc;
    self.attachment.anchorPoint = loc;
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:_anchorImgView.center];
    
    CGPoint P = [self convertPoint:_offsetImgView.center fromView:self.boxView];
    [path addLineToPoint:P];
    path.lineWidth = 6;
    
    [path stroke];
}
@end
