//
//  SFJOneParticleViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/20.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJOneParticleViewController.h"

@interface SFJOneParticleViewController ()
@property(nonatomic , strong)ParticleView *particleView;
@end

@implementation SFJOneParticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手指移动画线";
    [MBProgressHUD showAutoMessage:@"手指移动画线"];
    
    ParticleView *partview = [[ParticleView alloc]initWithFrame:self.view.bounds];
    partview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:partview];
    _particleView = partview;
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(16, 90, 80, 30)];
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"开始绘制" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(startAnim) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(16, 120, 40, 30)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"重绘" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(reDraw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

-(void)startAnim
{
    [_particleView startAnimate];
}

-(void)reDraw
{
    [_particleView reDraw];
}

@end


@interface ParticleView ()

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, weak) CALayer *dotLayer;

@property (nonatomic, weak) CAReplicatorLayer *repL;

@end

@implementation ParticleView

static int _instansCount = 0;

-(void)drawRect:(CGRect)rect
{
    [_path stroke];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CAReplicatorLayer *repL = [CAReplicatorLayer layer];
        repL.frame = self.bounds;
        [self.layer addSublayer:repL];
        
        CALayer *layer = [CALayer layer];
        CGFloat wh = 10;
        layer.frame = CGRectMake(0, -1000, wh, wh);
        layer.cornerRadius = wh/2;
        layer.backgroundColor = [UIColor blueColor].CGColor;
        [repL addSublayer:layer];
        
        _dotLayer = layer;
        _repL = repL;
    }
    return self;
}

// 重绘
- (void)reDraw
{
    _path = nil;
    _instansCount = 0;
    _dotLayer.hidden = YES;
    [self setNeedsDisplay];
}

// 绘制路径轨迹
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self reDraw];
    
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:curP];
    
    _path = path;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    [_path addLineToPoint:curP];
    
    [self setNeedsDisplay];
    
    _instansCount ++;
}

// 开始动画
-(void)startAnimate
{
    [_dotLayer removeAnimationForKey:@"CAKeyframeAnimation"];
    _dotLayer.hidden = NO;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = _path.CGPath;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 4;
    [_dotLayer addAnimation:anim forKey:@"CAKeyframeAnimation"];
    
    // 复制子层
    _repL.instanceCount = _instansCount;
    _repL.instanceDelay = 0.5;
}
@end

