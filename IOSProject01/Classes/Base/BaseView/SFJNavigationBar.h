//
//  SFJNavigationBar.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//  自定义导航条

#import <UIKit/UIKit.h>

@class SFJNavigationBar;

//导航条数据源
@protocol SFJNavigationBarDataSource <NSObject>

@optional

/** 头部标题样式 */
-(NSMutableAttributedString *)sfjNavigationBarTitle:(SFJNavigationBar *)navigationBar;
/** 背景图片 */
-(UIImage *)sfjNavigationBarBackgroundImage:(SFJNavigationBar *)navigationBar;
/** 背景色 */
-(UIColor *)sfjNavigationBarBackgroundColor:(SFJNavigationBar *)navigationBar;
/** 是否隐藏底部黑线 */
-(BOOL)sfjNavigationBarIsHideBottomLine:(SFJNavigationBar *)navigationBar;
/** 导航条高度 */
-(CGFloat)sfjNavigationBarHeight:(SFJNavigationBar *)navigationBar;
/** 导航条左边view */
-(UIView *)sfjNavigationBarLeftView:(SFJNavigationBar *)navigationBar;
/** 导航条右边view */
-(UIView *)sfjNavigationBarRightView:(SFJNavigationBar *)navigationBar;
/** 导航条中间view */
-(UIView *)sfjnavigationBarTitleView:(SFJNavigationBar *)navigationBar;
/** 导航条左边按钮 */
-(UIImage *)sfjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SFJNavigationBar *)navigationBar;
/** 导航条右边按钮 */
-(UIImage *)sfjNavigationBarRightButtonImage:(UIButton *)RightButton navigationBar:(SFJNavigationBar *)navigationBar;
@end

//导航条代理方法
@protocol SFJNavigationBarDelegate <NSObject>

@optional

/** 左边按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar;
/** 右边按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender naviagtionbar:(SFJNavigationBar *)navigationBar;
@end


@interface SFJNavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** 中间的view */
@property (weak, nonatomic) UIView *titleView;

/** 左边的view */
@property (weak, nonatomic) UIView *leftView;

/** 右边的view */
@property (weak, nonatomic) UIView *rightView;

/** 字体属性(下划线、大小、颜色...) */
@property (nonatomic, copy) NSMutableAttributedString *title;

/** 背景图 */
@property (weak, nonatomic) UIImage *backgroundImage;

@property (weak , nonatomic) id<SFJNavigationBarDataSource> navDataSource;

@property (weak , nonatomic) id<SFJNavigationBarDelegate> navDelegate;
@end
