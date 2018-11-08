//
//  SFJRunTimeViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/5.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJRunTimeViewController.h"

@interface SFJRunTimeViewController ()

@property (nonatomic, strong) UIButton *myButton;

@end

@implementation SFJRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myButton = [[UIButton alloc]init];
    self.myButton.backgroundColor = [UIColor colorWithHexString:@"0218f3"];
    self.myButton.height = 50;
    [self.myButton setTitle:@"" forState:UIControlStateNormal];
    
    self.tableview.tableHeaderView = self.myButton;
    //self.myButton addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)sfjNavigationBarLeftView:(SFJNavigationBar *)navigationBar
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    //view.backgroundColor = [UIColor grayColor];
    
    UIButton *icon = [[UIButton alloc]initWithFrame:CGRectMake(3, 5, 20, 30)];
    [icon setImage:[UIImage imageNamed:@"navigationBackBtn"] forState:UIControlStateNormal];
    
    UIImage *selectImage = [UIImage imageNamed:@"navigationButtonReturnClick"];
     selectImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [icon setImage:selectImage forState:UIControlStateSelected];
    [icon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:icon];
    
    UIButton *title = [[UIButton alloc]init];
    [title setTitle:@"基础知识" forState:UIControlStateNormal];
    
    //CGSize titleWidth = [@"基础知识" boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:0 attributes:@{NSFontAttributeName : AdaptedFontSize(12)} context:nil].size;
    title.frame = CGRectMake(25, 0, 80, 44);
   
    
    [title setTitleColor:[UIColor colorWithHexString:@"#0218f3"] forState:UIControlStateNormal];
    [title setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [title addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:title];
    
    return view;
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
