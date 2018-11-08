//
//  SFJDrwsPieViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/8/28.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJDrwsPieViewController.h"

@interface SFJDrwsPieViewController ()

@end

@implementation SFJDrwsPieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PieView *pie = [[PieView alloc]init];
    pie.backgroundColor = [UIColor lightGrayColor];
    [self.drawView addSubview:pie];
    [pie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.drawView);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    [self.view makeToast:@"点击扇形!!" duration:3 position:CSToastPositionCenter];
}

@end

@implementation PieView

- (NSArray *)arrRandom {
    int totoal = 100;
    NSMutableArray *arrM = [NSMutableArray array];
    int temp = 0; // 30 40 30
    for (int i = 0; i < arc4random_uniform(10) + 1; i++) {
        temp = arc4random_uniform(totoal) + 1;
        // 100 1~100
        // 随机出来的临时值等于总值，直接退出循环，因为已经把总数分配完毕，没必要在分配。
        [arrM addObject:@(temp)];
        // 解决方式：当随机出来的数等于总数直接退出循环。
        if (temp == totoal) {
            break;
        }
        totoal -= temp;
    }
    // 100 30 1~100
    // 70 40 0 ~ 69 1 ~ 70
    // 30 25
    // 5
    if (totoal) {
        [arrM addObject:@(totoal)];
    }
    return arrM;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    NSArray *arr = [self arrRandom];
    
    CGFloat radius = rect.size.width * 0.5;
    CGPoint center = CGPointMake(radius, radius);
    
    CGFloat startA = 0; //开始弧度
    CGFloat angle = 0;  //每段的弧度
    CGFloat endA = 0;   //结束弧度
    
    for (int i = 0; i < arr.count; i++) {
        startA = endA;
        angle = [arr[i] integerValue] / 100.0 * M_PI * 2;
        endA = startA + angle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:center];
        [[UIColor RandomColor] set];
        [path fill];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}
@end
