//
//  SFJSettingCell.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//  自定义 table view cell

#import <UIKit/UIKit.h>

@class SFJTableItem;

@interface SFJSettingCell : UITableViewCell

/** 静态单元格模型 */
@property (nonatomic , strong) SFJTableItem *item;

+(instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style;
@end
