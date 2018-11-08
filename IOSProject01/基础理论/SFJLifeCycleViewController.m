//
//  SFJLifeCycleViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/3.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJLifeCycleViewController.h"

@interface SFJLifeCycleViewController ()

@end

@implementation SFJLifeCycleViewController

#pragma ViewController生命周期
-(void)loadView
{
    [super loadView];
    
    [self life:__FUNCTION__];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self life:__FUNCTION__];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self life:__FUNCTION__];
    NSLog(@"%@",self.navigationItem.title);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self life:__FUNCTION__];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self life:__FUNCTION__];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self life:__FUNCTION__];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self life:__FUNCTION__];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self life:__FUNCTION__];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self life:__FUNCTION__];
}


-(void)life:(const char *)func
{
    SFJTableItem *item = [SFJTableItem itemWithTitle:[NSString stringWithUTF8String:func] subTitle:nil];
    
    item.titleFont = AdaptedFontSize(12);
    
    self.addItem(item);
    
    [self.tableview reloadData];
}

-(UIImage *)sfjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SFJNavigationBar *)navigationBar
{
    //[leftButton setBackgroundImage:[UIImage imageNamed:@"mine-sun-icon"] forState:UIControlStateSelected];
    return [UIImage imageNamed:@"NavgationBar_blue_back"];  //设置一般状态的图片
    
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
