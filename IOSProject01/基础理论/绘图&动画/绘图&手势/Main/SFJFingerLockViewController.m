//
//  SFJFingerLockViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJFingerLockViewController.h"

@interface SFJFingerLockViewController ()

@end

@implementation SFJFingerLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor blackColor];
   // self.drawView.backgroundColor = [UIColor whiteColor];
    LockView *view = [[LockView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kWIGTH , 400)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@interface LockView()
@property(nonatomic , strong) NSMutableArray<UIButton *> *selectedBtns;
@property(nonatomic , assign) CGPoint curP;
@end

@implementation LockView

- (NSMutableArray *)selectedBtns
{
    if(_selectedBtns == nil)
    {
        _selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupOnce];
    }
    return self;
}

- (void)setupOnce
{
    // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //创建九宫格按钮
    NSUInteger count = 9;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = i;
        btn.userInteractionEnabled = YES;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [self addSubview:btn];
    }
}

- (void)pan:(UIPanGestureRecognizer *)sender
{
    self.curP = [sender locationInView:self];
     NSArray<UIButton *> *btns = self.subviews;
    for (UIButton *btn in btns) {
        if (CGRectContainsPoint(btn.frame, self.curP) && !btn.selected) {   // 判断手 是否移动到 按钮上
            btn.selected = YES;
            [self.selectedBtns addObject:btn];  // 添加已选中的按钮
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSMutableString *strM = [NSMutableString string];
        
        for (UIButton *btn in self.selectedBtns) {
            [strM appendFormat:@"%zd", btn.tag];
        }
        
        NSLog(@"%@", strM);
        [self makeToast:[NSString stringWithFormat:@"拖拽顺序%@", strM] duration:3 position:CSToastPositionCenter];
        
        [self.selectedBtns makeObjectsPerformSelector:@selector(setSelected:) withObject:nil];
        
        [self.selectedBtns removeAllObjects];
    }
    [self setNeedsDisplay];  // 布局
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"gesture_node_normal"];
    NSUInteger cols = 3;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    CGFloat margin = (self.frame.size.width - cols * w) / (cols + 1);
    
    NSArray<UIButton *> *btns = self.subviews;
    for (NSUInteger i = 0; i < btns.count; i++) {
        x = margin + (i % cols) * (w + margin);
        y = margin + (i / cols) * (h + margin);
        btns[i].frame = CGRectMake(x, y, w, h);
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.selectedBtns.count == 0) return;
    
    NSUInteger count = self.selectedBtns.count;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.selectedBtns[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];   // 遍历已选中的按钮 ， 依次连线
        }
    }
    [path addLineToPoint:self.curP];
    
    [[UIColor greenColor] set];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 10;
    
    [path stroke];
}
@end
