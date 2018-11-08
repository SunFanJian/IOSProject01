//
//  SFJBasicKnowledgeViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJBasicKnowledgeViewController.h"
#import "SFJLifeCycleViewController.h"
#import "SFJBlockLoopViewController.h"
#import "SFJRunTimeViewController.h"
#import "SFJNSThreadViewController.h"
#import "SFJOperationViewController.h"
#import "SFJGCDViewController.h"
#import "SFJDrawRectViewController.h"
#import "SFJCoreAnimateViewController.h"
#import "SFJDynamicViewController.h"

@interface SFJBasicKnowledgeViewController ()

@end

@implementation SFJBasicKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets edgeInsets = self.tableview.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.height;
    self.tableview.contentInset = edgeInsets;
    
    SFJTableArrowItem *item00 = [SFJTableArrowItem itemWithTitle:@"ViewController的生命周期" subTitle:nil];
    item00.destVc = [SFJLifeCycleViewController class];
    
    SFJTableArrowItem *item01 = [SFJTableArrowItem itemWithTitle:@"Block 内存释放" subTitle:nil];
    item01.destVc = [SFJBlockLoopViewController class];
    
    SFJTableSection *section0 = [SFJTableSection sectionWithItems:@[item00,item01] andHeaderTitle:@"生命周期, block" footerTitle:nil];
    
    SFJTableArrowItem *item10 = [SFJTableArrowItem itemWithTitle:@"运行时RunTime 的知识运用" subTitle: nil];
    item10.destVc = [SFJRunTimeViewController class];
    
    SFJTableArrowItem *item11 = [SFJTableArrowItem itemWithTitle:@"RunLoop" subTitle: @"建议看"];
    
   // item14.destVc = [LMJRunLoopViewController class];
    
    SFJTableSection *section1 = [SFJTableSection sectionWithItems:@[item10, item11] andHeaderTitle:@"运行时RunTime, 运行循环RunLoop" footerTitle:nil];
    
    SFJTableArrowItem *item20 = [SFJTableArrowItem itemWithTitle:@"Thread 多线程" subTitle: nil];
    item20.destVc = [SFJNSThreadViewController class];
    
    SFJTableArrowItem *item21 = [SFJTableArrowItem itemWithTitle:@"GCD 多线程" subTitle: nil];
    item21.destVc = [SFJGCDViewController class];
    
    SFJTableArrowItem *item22 = [SFJTableArrowItem itemWithTitle:@"NSOperation 多线程" subTitle: nil];
    item22.destVc = [SFJOperationViewController class];
    
    SFJTableArrowItem *item23 = [SFJTableArrowItem itemWithTitle:@"同步锁知识" subTitle: @"NSLock @synchronized"];
   // item13.destVc = [LMJLockViewController class];
    
    SFJTableArrowItem *item24 = [SFJTableArrowItem itemWithTitle:@"列表图片s下载缓存" subTitle:@"SDWebImage列表图片模仿"];
   // item131.destVc = [LMJWebImagesCacheViewController class];
    
    SFJTableSection *section2 = [SFJTableSection sectionWithItems:@[item20, item21, item22, item23, item24] andHeaderTitle:@"多线程, 同步锁, 列表加载图片" footerTitle:nil];
    
    SFJTableArrowItem *item30 = [SFJTableArrowItem itemWithTitle:@"物理仿真" subTitle: @"UIDynamic"];
    
    item30.destVc = [SFJDynamicViewController class];
    
    SFJTableArrowItem *item31 = [SFJTableArrowItem itemWithTitle:@"核心动画 CoreAnimation" subTitle: @"CATransform3D"];
    item31.destVc = [SFJCoreAnimateViewController class];
    
    SFJTableArrowItem *item32 = [SFJTableArrowItem itemWithTitle:@"绘图Quartz2D" subTitle: @"Drawrect,贝塞尔,手势"];
    
    item32.destVc = [SFJDrawRectViewController class];
    
    SFJTableSection *section3 = [SFJTableSection sectionWithItems:@[item32, item31, item30] andHeaderTitle:@"绘图Quartz2D, 核心动画, 物理仿真" footerTitle:nil];
    
    [self.sections addObjectsFromArray:@[section0,section1,section2,section3]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataSource
/**头部标题*/
- (NSMutableAttributedString*)sfjNavigationBarTitle:(SFJNavigationBar *)navigationBar
{
    return [self changeTitle:@"基础知识列表"];
}

/** 导航条左边的按钮 */
- (UIImage *)sfjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SFJNavigationBar *)navigationBar
{
    [leftButton setTitle:@"左边😁" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor RandomColor] forState:UIControlStateNormal];
    [leftButton sizeToFit];
    leftButton.width += 10;
    leftButton.height = 44;
    return nil;
}
/** 导航条右边的按钮 */
- (UIImage *)sfjNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SFJNavigationBar *)navigationBar
{
    [rightButton setTitle:@"右边😁" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor RandomColor] forState:UIControlStateNormal];
    [rightButton sizeToFit];
    rightButton.width += 10;
    rightButton.height = 44;
    return nil;
}



#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
//    LMJWebViewController *ac = [LMJWebViewController new];
//    ac.gotoURL = @"https://baidu.com";
//
//    [self.navigationController pushViewController:ac animated:YES];
//    NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
//    LMJWebViewController *ac = [LMJWebViewController new];
//    ac.gotoURL = @"https://github.com/NJHu/iOSProject";
//
//    [self.navigationController pushViewController:ac animated:YES];
//    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}


@end
