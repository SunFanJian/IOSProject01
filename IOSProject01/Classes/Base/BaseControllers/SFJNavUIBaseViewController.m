//
//  SFJNavUIBaseViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJNavUIBaseViewController.h"

@interface SFJNavUIBaseViewController ()

@end

@implementation SFJNavUIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWeak(self);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem addObserverBlockForKeyPath:LMJKeyPath(self.navigationItem, title) block:^(id  _Nonnull obj, id  _Nonnull oldVal, NSString *_Nonnull newVal) {
        if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
            weakself.title = newVal;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.sfj_navgationBar.width = self.view.width;
    [self.view bringSubviewToFront:self.sfj_navgationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    [self.navigationItem removeObserverBlocksForKeyPath:LMJKeyPath(self.navigationItem, title)];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - DataSource
//显示自定义navBar  导航条
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(SFJNavUIBaseViewController *)navUIBaseViewController {
    return YES;
}


//头部标题
-(NSMutableAttributedString *)sfjNavigationBarTitle:(SFJNavigationBar *)navigationBar
{
     return [self changeTitle:self.title ? : self.navigationItem.title];
}

/** 背景图片 */
//- (UIImage *)sfjNavigationBarBackgroundImage:(SFJNavigationBar *)navigationBar
//{
//
//}

/** 背景色 */
- (UIColor *)sfjNavigationBarBackgroundColor:(SFJNavigationBar *)navigationBar {
    return [UIColor whiteColor];
}


/** 是否显示底部黑线 */
//- (BOOL)lmjNavigationIsHideBottomLine:(LMJNavigationBar *)navigationBar
//{
//    return NO;
//}

/** 导航条的高度 */
-(CGFloat)sfjNavigationBarHeight:(SFJNavigationBar *)navigationBar{
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}


/** 导航条的左边的 view */
//- (UIView *)sfjNavigationBarLeftView:(SFJNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的 view */
//- (UIView *)sfjNavigationBarRightView:(SFJNavigationBar *)navigationBar
//{
//
//}
/** 导航条中间的 View */
//- (UIView *)sfjNavigationBarTitleView:(SFJNavigationBar *)navigationBar
//{
//
//}
/** 导航条左边的按钮 */
//- (UIImage *)sfjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SFJNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的按钮 */
//- (UIImage *)sfjNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SFJNavigationBar *)navigationBar
//{
//
//}

#pragma mark - LMJNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
-(UIImage *)sfjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SFJNavigationBar *)navigationBar
{
    return [UIImage imageNamed:@"NavgationBar_blue_back"];  //设置一般状态的图片
    
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Delegate
/** 左边的按钮的点击 */
//-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar {
//    NSLog(@"%s", __func__);
//}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(SFJNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}

#pragma mark 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
    
    return title;
}

- (SFJNavigationBar *)sfj_navgationBar {
    // 父类控制器必须是导航控制器
    if(!_sfj_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]])
    {
        SFJNavigationBar *navigationBar = [[SFJNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        [self.view addSubview:navigationBar];
        _sfj_navgationBar = navigationBar;
        
        navigationBar.navDataSource = self;
        navigationBar.navDelegate = self;
        navigationBar.hidden = ![self navUIBaseViewControllerIsNeedNavBar:self];
    }
    return _sfj_navgationBar;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.sfj_navgationBar.title = [self changeTitle:title];
}
@end
