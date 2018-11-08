//
//  SFJChildBlockViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/3.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJChildBlockViewController.h"

@interface SFJChildBlockViewController ()
@property(nonatomic , assign)int global;

@end

@implementation SFJChildBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.successBlock(@"111");   //调用
    
    int localNum = 10;
    self.global = 100;
    static int staticNum = 1000;
    
    LMJWeak(self);
    
    //赋值
    self.failedBlock = ^NSString *(NSString *str1, NSString *str2) {
        NSString *str = [NSString stringWithFormat:@"%@--%@\n在声明Block之后、调用Block之前对局部、全局、静态变量进行修改,在调用Block时局部变量值是修改之前的旧值，而全局、静态变量是修改后的值: %d,%d,%d",str1 , str2, localNum , weakself.global , staticNum];
        return str;
    };
    localNum = 11;
    self.global = 111;
    staticNum = 111;
    //调用
    NSLog(@"%@",self.failedBlock(@"111",@"222"));
    
    //3.使用typedef定义的block
    self.type1Block = ^int(int i, int j) {
        return i + j;
    };
    
   NSLog(@"%d",self.type1Block(20, 30));

}

-(void)simpleBlockInFunction:(NSString * (^)(NSString *, int))blockName
{
    //直接调用
    blockName(@"testStr",1000);
}

-(void)blockUseInOC:(NSString *)normalStr withBlock1:(void (^)(NSString *, int))blockName1 andBlock2:(int (^)(NSArray *, BOOL))blockName2
{
    
}

-(void)useTypedefBlock:(Compare)type2Block
{
   type2Block(30, 30);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 导航条左边的按钮 */
-(UIImage *)sfjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SFJNavigationBar *)navigationBar
{
    return [UIImage imageNamed:@"NavgationBar_blue_back"];  //设置一般状态的图片
    
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
