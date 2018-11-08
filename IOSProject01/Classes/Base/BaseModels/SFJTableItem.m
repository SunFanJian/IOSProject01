//
//  SFJTableItem.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
// 自定义tableview item 模型

#import "SFJTableItem.h"

@implementation SFJTableItem

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    SFJTableItem *item = [[self alloc]init];
    item.subTitle = subTitle;
    item.title = title;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void (^)(NSIndexPath *))itemOperation
{
    SFJTableItem *item = [self itemWithTitle:title subTitle:subTitle];
    item.itemOperation = itemOperation;
    return  item;
}

-(instancetype)init
{
    if (self = [super init]) {
        _titleColor = [UIColor blackColor];
        _subTitleColor = [UIColor blackColor];
        //        _cellHeight = AdaptedWidth(50);
        _titleFont = AdaptedFontSize(16);
        _subTitleFont = AdaptedFontSize(16);
        _subTitleNumberOfLines = 2;
    }
    return self;
}

//设置cell高度
-(CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight += 20;
        NSString *totalString = [NSString stringWithFormat:@"%@%@",self.title,self.subTitle];
        //计算 字符串高度
        // 参数1: 自适应尺寸,提供一个宽度,去自适应高度
        // 参数2:自适应设置 (以行为矩形区域自适应,以字体字形自适应)
        // 参数3:文字属性,通常这里面需要知道是字体大小
        // 参数4:绘制文本上下文,做底层排版时使用,填nil即可
        _cellHeight += [totalString boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : self.subTitleFont} context:nil].size.height;
        _cellHeight = MAX(_cellHeight, 45);
        _cellHeight = AdaptedWidth(_cellHeight);
        //_cellHeight = AdaptedHeight(_cellHeight);
    }
    return  _cellHeight;
}
@end
