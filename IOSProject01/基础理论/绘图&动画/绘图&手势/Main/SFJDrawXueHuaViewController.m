//
//  SFJDrawXueHuaViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDrawXueHuaViewController.h"

@interface SFJDrawXueHuaViewController ()

@end

@implementation SFJDrawXueHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    DrawSnowView *view = [[DrawSnowView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kWIGTH , kHIGHT - NAVIGATION_BAR_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}
@end

@interface DrawSnowView()
@property (weak, nonatomic) CADisplayLink *link;
@end

@implementation DrawSnowView

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 如果以后想绘制东西到view上面，必须在drawRect方法里面，不管有没有手动获取到上下文
    // 修改雪花y值
    
    static CGFloat _snowY;
    UIImage *image = [UIImage imageNamed:@"雪花.png"];
    [image drawAtPoint:CGPointMake(50, _snowY)];
    _snowY += 1;
    if (_snowY > rect.size.height) {
        _snowY = 0;
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
    }
    return self;
}

- (void)setupUIOnce
{
    // 创建定时器
    //    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    // CADisplayLink:每次屏幕刷新的时候就会调用，屏幕一般一秒刷新60次
    LMJWeak(self);
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:weakself selector:@selector(setNeedsDisplay)];   //每次刷新屏幕 重新绘图
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _link = link;
}

- (void)dealloc {
    [_link invalidate];
    _link = nil;
}
@end
