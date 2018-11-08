//
//  SFJDrawProgressViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/8/28.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDrawProgressViewController.h"

@interface SFJDrawProgressViewController ()
@property(nonatomic , weak)ProgressView *progressView;
@property(nonatomic , weak)UILabel *progressLabel;
@end

@implementation SFJDrawProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   ProgressView *progressview = [[ProgressView alloc]init];
    progressview.backgroundColor = [UIColor lightGrayColor];
    [self.drawView addSubview:progressview];
    _progressView = progressview;
    
    UILabel *progressLabel = [[UILabel alloc]init];
    [progressview addSubview:progressLabel];
    _progressLabel = progressLabel;
    
    UISlider *slider1 = [[UISlider alloc]init];
    slider1.value = 0;
    slider1.minimumValue = 0;
    slider1.maximumValue = 1;
    [slider1 addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.drawView addSubview:slider1];
    
    [progressview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.drawView);
        make.top.equalTo(self.drawView).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    [progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(progressview);
    }];
    
    [slider1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progressview.mas_bottom).offset(80);
        make.left.equalTo(self.drawView).offset(20);
        make.right.equalTo(self.drawView).offset(-30);
        make.height.equalTo(@40);
    }];
    
}

-(void)changeValue:(UISlider *)slider
{
    _progressLabel.text = [NSString stringWithFormat:@"%.2f%%",slider.value * 100];
    _progressView.progress = slider.value;
}
@end

@implementation ProgressView
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    // 重新绘制圆弧
    // 重绘，系统会先创建与view相关联的上下文，然后再调用drawRect
    [self setNeedsDisplay];
}

// 注意：drawRect不能手动调用，因为图形上下文我们自己创建不了，只能由系统帮我们创建，并且传递给我们
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 创建贝瑟尔路径
    CGFloat radius = rect.size.width * 0.5;
    CGPoint center = CGPointMake(radius, radius);
    
    CGFloat endA = -M_PI_2 + _progress * M_PI * 2;
    
    UIBezierPath *path0 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    path0.lineWidth = 5;
    [[UIColor greenColor] setStroke];
    [path0 stroke];
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius - 1 startAngle:-M_PI_2 endAngle:endA clockwise:YES];
    path.lineWidth = 2;
    [[UIColor redColor] setStroke];
    [path stroke];
}
@end
