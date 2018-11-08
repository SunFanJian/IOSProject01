//
//  SFJMuchParticleViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/20.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJMuchParticleViewController.h"

@interface SFJMuchParticleViewController ()
@property(nonatomic , strong)ParticleView1 *particleView;
@end

@implementation SFJMuchParticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手指移动画线";
    [MBProgressHUD showAutoMessage:@"手指移动画线"];
    
    ParticleView1 *partview = [[ParticleView1 alloc]initWithFrame:self.view.bounds];
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

@interface ParticleView1 ()

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, weak) CALayer *dotLayer;

@property (nonatomic, weak) CAReplicatorLayer *repL;

@end

@implementation ParticleView1

static int _instansCount = 0;

-(CALayer *)dotLayer
{
    if (!_dotLayer) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, -1000, 10, 10);
        layer.cornerRadius = 5;
        layer.backgroundColor = [UIColor blueColor].CGColor;
        [_repL addSublayer:layer];
        _dotLayer = layer;
    }
    return  _dotLayer;
}

-(UIBezierPath *)path
{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CAReplicatorLayer *repL = [CAReplicatorLayer layer];
        repL.frame = self.bounds;
        _repL = repL;
        [self.layer addSublayer:repL];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [_path stroke];
}

-(void)reDraw
{
    _path = nil;
        // 把图层移除父控件，复制层也会移除。
    [_dotLayer removeFromSuperlayer];
    _dotLayer = nil;
    _instansCount = 0;
    
    [self setNeedsDisplay];
}

-(void)startAnimate
{
    // 子层添加动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = _path.CGPath;
    anim.duration = 3;
    anim.repeatCount = MAXFLOAT;
    [self.dotLayer addAnimation:anim forKey:nil];
    
    // 注意:如果复制的子层有动画，先添加动画，在复制
    // 复制子层
    _repL.instanceCount = _instansCount;
    _repL.instanceDelay = 0.2;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    [self.path moveToPoint:curP];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    [self.path addLineToPoint:curP];
    
    [self setNeedsDisplay]; //重绘
    _instansCount ++;
}
@end
