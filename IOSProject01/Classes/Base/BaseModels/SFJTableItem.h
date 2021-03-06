//
//  SFJTableItem.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//  TableView Item  数据模型

#import <Foundation/Foundation.h>

@interface SFJTableItem : NSObject

/** 标题 */
@property (nonatomic , copy) NSString *title;
/** 标题字体 */
@property (nonatomic , strong) UIFont *titleFont;
/** 标题颜色 */
@property (nonatomic , strong) UIColor *titleColor;

/** 副标题 */
@property (nonatomic , copy) NSString *subTitle;
/** 副标题字体 */
@property (nonatomic , strong) UIFont *subTitleFont;
/** 副标题颜色 */
@property (nonatomic , strong) UIColor *subTitleColor;
/** 副标题行数限制 */
@property (nonatomic , assign) NSInteger subTitleNumberOfLines;

/** 左边的图片 UIImage 或者 NSURL 或者 URLString 或者 ImageName */
@property (nonatomic, strong) id image;

/** 设置cell的高度, 默认45 */
@property (assign, nonatomic) CGFloat cellHeight;


/** 是否自定义这个cell , 如果自定义, 则在tableview返回默认的cell, 自己需要自定义cell返回*/
@property (assign, nonatomic, getter=isNeedCustom) BOOL needCustom;

/** 点击操作 */
@property (nonatomic, copy) void(^itemOperation)(NSIndexPath *indexPath);

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation;

@end
