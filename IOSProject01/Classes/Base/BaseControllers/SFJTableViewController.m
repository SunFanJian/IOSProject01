//
//  SFJTableViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJTableViewController.h"

@interface SFJTableViewController ()
@property(nonatomic , assign)UITableViewStyle tableViewStyle;
@end

@implementation SFJTableViewController

-(UITableView *)tableview
{
    if (!_tableview) {
        UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:self.tableViewStyle];
        [self.view addSubview:tableview];
        //自动调整tableview的宽高，保证左右，上下边距不变
        tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableview = tableview;
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBaseTableviewUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupBaseTableviewUI
{
    //self.tableview.backgroundColor = self.view.backgroundColor;
    self.tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // 当存在导航条的时候，距屏幕顶部的距离 需要再加个 导航栏的高度
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        UIEdgeInsets contentInset = self.tableview.contentInset;
        //contentInset.top += NAVIGATION_BAR_HEIGHT;
        contentInset.top += self.sfj_navgationBar.height;
        self.tableview.contentInset = contentInset;
    }
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    // 适配 ios 11
    if (@available(iOS 11.0, *)){
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

//初始化
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        _tableViewStyle = style;
    }
    return self;
}



#pragma mark - scrollDeleggate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];  //滚动时回收键盘
}

#pragma mark - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)dealloc {
    
}

@end
