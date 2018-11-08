//
//  SFJTableSection.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJTableSection.h"

@implementation SFJTableSection

+(instancetype)sectionWithItems:(NSArray<SFJTableItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    SFJTableSection *section = [[self alloc] init];
    if (items.count) {
        [section.items addObjectsFromArray:items];
    }
    section.headerTitle = headerTitle;
    section.footerTitle = footerTitle;
    
    return section;
}

-(NSMutableArray<SFJTableItem *> *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return  _items;
}

-(CGFloat)headerHeight
{
    if (!_headerHeight) {
        _headerHeight += [self.headerTitle boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : AdaptedFontSize(17)} context:nil].size.height ;
        _headerHeight = MIN(_headerHeight, 45);
        _headerHeight = AdaptedWidth(_headerHeight);
    }
    return _headerHeight;
}

-(CGFloat)footerHeight
{
    if (!_footerHeight) {
        _footerHeight += [self.footerTitle boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : AdaptedFontSize(17)} context:nil].size.height ;
        _footerHeight = MIN(_footerHeight, 45);
        _footerHeight = AdaptedWidth(_footerHeight);
    }
    return _footerHeight;
}

@end
