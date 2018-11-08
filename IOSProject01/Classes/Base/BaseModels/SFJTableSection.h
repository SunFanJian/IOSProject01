//
//  SFJTableSection.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//  tableview 分组 模型

#import <Foundation/Foundation.h>

@class SFJTableItem;

@interface SFJTableSection : NSObject

/** digest */
@property (nonatomic, copy) NSString *headerTitle;

/** <#digest#> */
@property (nonatomic, copy) NSString *footerTitle;

/** 设置header的高度, 默认45 */
@property (assign, nonatomic) CGFloat headerHeight;

/** 设置footer的高度, 默认45 */
@property (assign, nonatomic) CGFloat footerHeight;

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<SFJTableItem *> *items;

+ (instancetype)sectionWithItems:(NSArray<SFJTableItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;
@end
