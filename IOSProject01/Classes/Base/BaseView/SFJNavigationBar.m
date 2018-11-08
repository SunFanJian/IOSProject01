//
//  SFJNavigationBar.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJNavigationBar.h"

//状态栏高度
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
//默认导航条高度
#define kDefaultNavBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)
//左右按钮默认大小
#define kSmallTouchSizeHeight 44.0

#define kLeftRightViewSizeMinWidth 60.0

//外边距
#define kViewMargin 5.0

@implementation SFJNavigationBar


//1.重新init方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

//2.布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    //层次切换
    [self.superview bringSubviewToFront:self];  //将当前视图（自定义的导航条）推到前面
    
    self.leftView.frame = CGRectMake(0, kStatusBarHeight, self.leftView.width, self.leftView.height);
    
    self.rightView.frame = CGRectMake(self.width - self.rightView.width, kStatusBarHeight, self.rightView.width, self.rightView.height);
    
    self.titleView.frame = CGRectMake(0, kStatusBarHeight + (44.0 - self.titleView.height) * 0.5, MIN(self.width - MAX(self.leftView.width, self.rightView.width) * 2 - kViewMargin * 2, self.titleView.width), self.titleView.height);
    
    self.titleView.left = (self.width * 0.5 - self.titleView.width * 0.5);  //X
    
    self.bottomBlackLineView.frame = CGRectMake(0, self.height, self.width, 0.5);
}

//3.setter 方法
#pragma mark - Setter
-(void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    
    _titleView = titleView;
    
    __block BOOL isHavetagGes = NO;
    
    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            isHavetagGes = YES;
            *stop = YES;
        }
    }];
    
    if (!isHavetagGes) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selector)];
        
        //给导航条中间的view添加手势
        [titleView addGestureRecognizer:tap];
    }
    
     [self layoutIfNeeded];
}

-(void)setTitle:(NSMutableAttributedString *)title
{
    //当存在中间view的时候 ，返回
    if ([self.navDataSource respondsToSelector:@selector(sfjnavigationBarTitleView:)] && [self.navDataSource sfjnavigationBarTitleView:self]) {
        return;
    }
    // 不存在中间的view 则创建一个label，显示头部标题
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width * 0.4, 44)];
    navTitleLabel.numberOfLines=0;//可能出现多行的标题
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;     //正常响应Touch、Move等事件
    navTitleLabel.lineBreakMode = NSLineBreakByClipping;   //换行时 以字符为单位截断
    
    self.titleView = navTitleLabel;
}

-(void)setLeftView:(UIView *)leftView
{
    [_leftView removeFromSuperview];
    [self addSubview:leftView];
    _leftView = leftView;
    
    if ([leftView isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)leftView;
        
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];  //强制整个view立即进行层次布局
}

-(void)setRightView:(UIView *)rightView
{
    [_rightView removeFromSuperview];
    [self addSubview:rightView];
    _rightView = rightView;
    
    if ([rightView isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)rightView;
        
        [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];  //强制整个view立即进行层次布局
}

-(void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    self.layer.contents = (id)backgroundImage.CGImage;
}

//set  数据源
-(void)setNavDataSource:(id<SFJNavigationBarDataSource>)navDataSource
{
    _navDataSource = navDataSource;
    
    [self setupDataSourceUI];
}

#pragma mark - getter

- (UIView *)bottomBlackLineView
{
    if(!_bottomBlackLineView)
    {
        CGFloat height = 0.5;
        UIView *bottomBlackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, height)];
        [self addSubview:bottomBlackLineView];
        _bottomBlackLineView = bottomBlackLineView;
        bottomBlackLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomBlackLineView;
}


#pragma mark - event
-(void)titleClick:(UIGestureRecognizer *)tap
{
    UILabel *view = (UILabel *)tap.view;
    if ([self.navDelegate respondsToSelector:@selector(titleClickEvent:naviagtionbar:)]) {
        [self.navDelegate titleClickEvent:view naviagtionbar:self];
    }
}

-(void)leftBtnClick:(UIButton *)btn
{
    if ([self.navDelegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
        [self.navDelegate leftButtonEvent:btn navigationBar:self];
    }
}

-(void)rightBtnClick:(UIButton *)btn
{
    if ([self.navDelegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {
        [self.navDelegate rightButtonEvent:btn navigationBar:self];
    }
}

//设置数据源
-(void)setupDataSourceUI
{
    //导航条高度
    if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarHeight:)]) {
        self.size = CGSizeMake(kScreenWidth, [self.navDataSource sfjNavigationBarHeight:self]);
    }
    else{
        self.size = CGSizeMake(kScreenWidth, kDefaultNavBarHeight);
    }
    
    //是否显示底部黑线
    if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarIsHideBottomLine:)]) {
        if ([self.navDataSource sfjNavigationBarIsHideBottomLine:self]) {
            self.bottomBlackLineView.hidden = YES;
        }
    }
    
    //背景图片
    if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarBackgroundImage:)]) {
        self.backgroundImage = [self.navDataSource sfjNavigationBarBackgroundImage:self];
    }
    
    //背景色
    if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarBackgroundColor:)]) {
        self.backgroundColor = [self.navDataSource sfjNavigationBarBackgroundColor:self];
    }
    
    //导航条中间的view
    if ([self.navDataSource respondsToSelector:@selector(sfjnavigationBarTitleView:)]) {
        self.titleView = [self.navDataSource sfjnavigationBarTitleView:self];
        
    }else if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarTitle:)]){
        self.title = [self.navDataSource sfjNavigationBarTitle:self];
    }
    
    /** 导航条的左边的 view */
    /** 导航条左边的按钮 */
    if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarLeftView:)]) {
        
        self.leftView = [self.navDataSource sfjNavigationBarLeftView:self];
        
    }else if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarLeftButtonImage:navigationBar:)])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSmallTouchSizeHeight, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage *image = [self.navDataSource sfjNavigationBarLeftButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.leftView = btn;
    }
    
    /** 导航条右边的 view */
    /** 导航条右边的按钮 */
    if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarRightView:)]) {
        
        self.rightView = [self.navDataSource sfjNavigationBarRightView:self];
        
    }else if ([self.navDataSource respondsToSelector:@selector(sfjNavigationBarRightButtonImage:navigationBar:)])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLeftRightViewSizeMinWidth, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage *image = [self.navDataSource sfjNavigationBarRightButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.rightView = btn;
    }
        
}
@end
